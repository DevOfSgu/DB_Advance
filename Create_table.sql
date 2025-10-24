use library_management;

create table Publisher(
	publisherID int auto_increment primary key,
    publisherName nvarchar(100) not null,
    address nvarchar(255)
);

create table Author(
	authorID int auto_increment primary key,
    authorName nvarchar(100) not null
);

create table Location(
	locationID int auto_increment primary key,
    shelf nvarchar(50) not null unique,
    section nvarchar(100) not null,
    description nvarchar(255)
);

create table bookType(
	bookTypeID int auto_increment primary key,
    bookTypeName nvarchar(100) not null
);

create table Book(
	bookID int auto_increment primary key ,
    bookTypeID int,
    bookName nvarchar(100) not null,
    PublishYear int,
    rentalPrice decimal(10, 0) not null,    
    publisherID int not null,
    foreign key (publisherID) references Publisher(publisherID) ON DELETE CASCADE,
    foreign key (bookTypeID) references bookType(bookTypeID) ON DELETE CASCADE
);

-- kiểm tra ngày trước khi lưu vô db
DELIMITER //

CREATE TRIGGER check_publish_year_before_insert
BEFORE INSERT ON Book 
FOR EACH ROW
BEGIN
    IF NEW.PublishYear < 1000 OR NEW.PublishYear > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'PublishYear must be between 1000 and current year';
    END IF;
END;
//

DELIMITER ;

create table bookCopy(
	copyID int auto_increment primary key, 
    bookID int not null,
    locationID int not null,
    bookCondition ENUM('New', 'Good', 'Fair', 'Damaged') not null,
    status ENUM('Available', 'Rented', 'Lost', 'Damaged') default 'Available' ,
    foreign key (bookID) references Book(bookID) ON DELETE CASCADE,
    foreign key (locationID) references Location(locationID) ON DELETE CASCADE
 );

create table book_Author(
	bookID int not null,
    authorID int not null,
	primary key (bookID, authorID),
    foreign key (bookID) references Book(bookID) ON DELETE CASCADE,
    foreign key (authorID) references Author(authorID) ON DELETE CASCADE
);

create table Member(
	memberID int auto_increment primary key,
    memberName nvarchar(50) not null,
    dayOfBirth date not null,
    memberAddress nvarchar(100),
    memberPhoneNumber varchar(10) not null unique,
    memberEmail varchar(50) unique,
    createCardDate date not null default (curdate()),
    expiredDate date,
    status ENUM('Active', 'Inactive', 'Expired') DEFAULT 'Active'
);

create table Librarian(
	librarianID int auto_increment primary key,
    librarianName nvarchar(50) not null,
    dayOfBirth date,
    librarianPhoneNumber varchar(10) not null unique
);

create table bookLoan(
	loanID int auto_increment primary key,
    memberID int, 
    librarianID int,
    borrowDate date not null,
    dueDate date not null,
    status ENUM('Borrowed', 'Returned', 'Overdue') default 'Borrowed',
    foreign key (memberID) references Member(memberID) ON DELETE SET NULL,
    foreign key (librarianID) references Librarian(librarianID) ON DELETE SET NULL
);

create table bookLoanDetail(
	loanDetailID int auto_increment primary key,
	loanID int not null,
    copyID int not null,
    returnDate date,
	bookConditionOut ENUM('New', 'Good', 'Fair', 'Damaged') DEFAULT 'Good',
	bookConditionIn ENUM('New', 'Good', 'Fair', 'Damaged') DEFAULT 'Good',
    foreign key (loanID) references bookLoan(loanID) ON DELETE CASCADE,
    foreign key (copyID) references bookCopy(copyID) ON DELETE CASCADE,
    unique key uk_loan_copy (loanID, copyID)
);

create table Penalty(
	penaltyID int auto_increment primary key,
    loanDetailID int not null,
    reason nvarchar(100),
    fine decimal(10, 0) not null, 
    processDate date,
    status ENUM('Unpaid', 'Paid') default 'Unpaid',
    foreign key (loanDetailID) references bookloanDetail(loanDetailID) ON DELETE CASCADE    
);

ALTER TABLE Member
MODIFY COLUMN status ENUM('Active', 'Inactive', 'Expired', 'Blocked') DEFAULT 'Active';

-- Trigger tự động cập nhật trạng thái sách KHI CHO MƯỢN
-- Trigger 1: Tự động điền bookConditionOut
DELIMITER //

CREATE TRIGGER trg_before_loan_detail_insert_set_condition
BEFORE INSERT ON bookLoanDetail
FOR EACH ROW
BEGIN
    DECLARE v_book_condition ENUM('New', 'Good', 'Fair', 'Damaged');

    SELECT bookCondition INTO v_book_condition
    FROM bookCopy
    WHERE copyID = NEW.copyID;
    
    SET NEW.bookConditionOut = v_book_condition;
END //

DELIMITER ;


-- Trigger 2: Cập nhật trạng thái sách (giống trigger cũ của bạn)
DELIMITER //

CREATE TRIGGER trg_after_loan_detail_insert
AFTER INSERT ON bookLoanDetail
FOR EACH ROW
BEGIN
    UPDATE bookCopy
    SET status = 'Rented'
    WHERE copyID = NEW.copyID;
END //

DELIMITER ;

-- Trigger tự động cập nhật trạng thái sách KHI TRẢ SÁCH
DELIMITER //

CREATE TRIGGER trg_after_loan_detail_update
AFTER UPDATE ON bookLoanDetail
FOR EACH ROW
BEGIN
    -- Chỉ thực hiện khi sách được trả (returnDate từ NULL thành có giá trị)
    IF OLD.returnDate IS NULL AND NEW.returnDate IS NOT NULL THEN
        -- Dựa vào tình trạng sách khi trả (bookConditionIn) để cập nhật
        IF NEW.bookConditionIn = 'Damaged' THEN
            -- Cập nhật cả trạng thái nghiệp vụ và tình trạng vật lý
            UPDATE bookCopy 
            SET status = 'Damaged', 
                bookCondition = 'Damaged'
            WHERE copyID = NEW.copyID;

        ELSEIF NEW.bookConditionIn = 'Lost' THEN
            UPDATE bookCopy 
            SET status = 'Lost' 
            WHERE copyID = NEW.copyID;
            
        ELSE -- Sách trả về trong tình trạng tốt
            UPDATE bookCopy 
            SET status = 'Available' 
            WHERE copyID = NEW.copyID;
        END IF;
    END IF;
END //

DELIMITER ;

-- Trigger tự động TẠO PHIẾU PHẠT (kết hợp)
DELIMITER //

CREATE TRIGGER trg_create_penalty_on_return
AFTER UPDATE ON bookLoanDetail
FOR EACH ROW
BEGIN
    DECLARE v_due_date DATE;
    DECLARE v_fine DECIMAL(10, 0) DEFAULT 0;
    DECLARE v_reason NVARCHAR(255) DEFAULT '';

    -- Chỉ thực hiện khi sách được trả
    IF OLD.returnDate IS NULL AND NEW.returnDate IS NOT NULL THEN
        -- Lấy ngày hẹn trả từ bảng bookLoans
        SELECT dueDate INTO v_due_date FROM bookLoan WHERE loanID = NEW.loanID;

        -- Kiểm tra nếu trả muộn
        IF NEW.returnDate > v_due_date THEN
            SET v_fine = v_fine + 20000; -- Phí phạt trả muộn (ví dụ)
            SET v_reason = CONCAT(v_reason, 'Trả sách muộn; ');
        END IF;

        -- Kiểm tra nếu sách bị hỏng hoặc mất
        IF NEW.bookConditionIn = 'Damaged' THEN
            SET v_fine = v_fine + 50000; -- Phí phạt làm hỏng sách (ví dụ)
            SET v_reason = CONCAT(v_reason, 'Làm hỏng sách; ');
        ELSEIF NEW.bookConditionIn = 'Lost' THEN
            SET v_fine = v_fine + 100000; -- Phí phạt làm mất sách (ví dụ)
            SET v_reason = CONCAT(v_reason, 'Làm mất sách; ');
        END IF;

        -- Nếu có lý do phạt (tức là v_fine > 0) thì tạo phiếu phạt
        IF v_fine > 0 THEN
            INSERT INTO Penalty (loanDetailID, reason, fine, processDate, status)
            VALUES (NEW.loanDetailID, TRIM(TRAILING '; ' FROM v_reason), v_fine, CURDATE(), 'Unpaid');
        END IF;
    END IF;
END //

DELIMITER ;

-- Trigger quản lý trạng thái thẻ thành viên (Blocked và Active)
DELIMITER //

CREATE TRIGGER trg_block_member_on_penalty
AFTER INSERT ON Penalty
FOR EACH ROW
BEGIN
    DECLARE v_member_id INT;

    -- Tìm memberID từ loanDetailID của phiếu phạt mới
    SELECT bl.memberID INTO v_member_id
    FROM bookLoan bl
    JOIN bookLoanDetail bld ON bl.loanID = bld.loanID
    WHERE bld.loanDetailID = NEW.loanDetailID;

    -- Cập nhật trạng thái thành viên thành 'Inactive'
    IF v_member_id IS NOT NULL THEN
        UPDATE Member SET status = 'Inactive' WHERE memberID = v_member_id;
    END IF;
END //

DELIMITER ;

-- Trigger MỞ KHÓA THẺ khi thanh toán hết phiếu phạt
DELIMITER //

CREATE TRIGGER trg_unblock_member_on_payment
AFTER UPDATE ON Penalty
FOR EACH ROW
BEGIN
    DECLARE v_member_id INT;
    DECLARE v_unpaid_count INT;
    DECLARE v_expired_date DATE;

    -- Chỉ chạy khi trạng thái chuyển từ 'Unpaid' sang 'Paid'
    IF OLD.status = 'Unpaid' AND NEW.status = 'Paid' THEN
        -- Tìm memberID và ngày hết hạn thẻ
        SELECT bl.memberID, m.expiredDate INTO v_member_id, v_expired_date
        FROM bookLoan bl
        JOIN bookLoanDetail bld ON bl.loanID = bld.loanID
        JOIN Member m ON m.memberID = bl.memberID
        WHERE bld.loanDetailID = NEW.loanDetailID;

        IF v_member_id IS NOT NULL THEN
            -- Đếm số phiếu phạt chưa thanh toán còn lại của thành viên này
            SELECT COUNT(*) INTO v_unpaid_count
            FROM Penalty p
            JOIN bookLoan_detail bld ON p.loanDetailID = bld.loanDetailID
            JOIN bookLoan bl ON bld.loanID = bl.loanID
            WHERE bl.memberID = v_member_id AND p.status = 'Unpaid';

            -- Nếu không còn phiếu phạt nào, mở khóa thẻ
            IF v_unpaid_count = 0 THEN
                -- Kiểm tra xem thẻ có bị hết hạn không
                IF v_expired_date < CURDATE() THEN
                    UPDATE Member SET status = 'Expired' WHERE memberID = v_member_id;
                ELSE
                    UPDATE Member SET status = 'Active' WHERE memberID = v_member_id;
                END IF;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- Quan trọng: Bạn cần đảm bảo Event Scheduler đang được bật. Chạy lệnh này một lần:
SET GLOBAL event_scheduler = ON;

-- Tạo Sự kiện (Event) để xử lý thẻ hết hạn (Expired)
-- Mục đích: Mỗi ngày, tự động tìm tất cả các thành viên có thẻ đã hết hạn (expiredDate < ngày hiện tại) và đang ở trạng thái 'Active' để chuyển sang 'Expired'.
-- Lịch chạy: Hàng ngày, vào lúc 01:00 sáng.
DELIMITER //

CREATE EVENT evt_update_expired_members
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURDATE(), '01:00:00')
DO
BEGIN
    -- Cập nhật trạng thái của các thành viên có thẻ đã hết hạn và đang Active
    UPDATE Member
    SET status = 'Expired'
    WHERE expiredDate < CURDATE() AND status = 'Active';
END //

DELIMITER ;        