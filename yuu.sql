use library_management;

-- update status penalty
-- UPDATE Penalty 
-- SET status = 'Paid' 
-- WHERE penaltyID IN (1, 2, 3, 4, 5);

-- insert cho câu 15 
-- INSERT INTO Book (bookName, bookTypeID, PublishYear, rentalPrice, publisherID) VALUES ('Số đỏ', 1, 1936, 10000, 5);
-- INSERT INTO Author (authorName) VALUES ('Vũ Trọng Phụng');
-- -- Giả sử bookID mới là 11 và authorID mới là 11
-- INSERT INTO book_Author (bookID, authorID) VALUES (11, 11);

-- 11. Yêu cầu: Tìm những ngày có hơn 1 phiếu mượn được tạo
select bl.borrowDate,  
        count(bl.loanID) as number_of_loan_vouchers
from bookLoan bl, librarian l
where bl.librarianID = l.librarianID
group by bl.borrowDate
having count(bl.loanID) > 1;

-- 12. Yêu cầu: Liệt kê các thành viên có tổng số tiền phạt (chưa tính đã trả hay chưa) lớn hơn 50000.
SELECT M.memberID, 
    M.memberName, 
SUM(P.totalFine) AS total_fines
FROM Member M, 
    bookLoan BL, 
    bookLoanDetail BLD, 
    Penalty P
Where M.memberID = BL.memberID and BL.loanID = BLD.loanID and BLD.loanDetailID = P.loanDetailID
GROUP BY M.memberID
HAVING SUM(P.totalFine) > 50000;

-- 13. Yêu cầu: Tìm tất cả các bản sao sách (bookCopy) của tác giả 'Nguyễn Nhật Ánh'.
select bc.copyID, 
        b.bookName, 
        bc.bookCondition, 
        bc.status
from bookcopy bc, book b
where bc.bookID = b.bookID and bc.copyID in (
	select ba.bookID
    from book_author ba, author a
    where BA.authorID = A.authorID 
    and a.authorName = 'Nguyễn Nhật Ánh'
);

-- 14. Yêu cầu: Liệt kê các thành viên đã từng mượn sách thuộc khu vực 'Văn học Việt Nam'.
SELECT DISTINCT M.memberID, M.memberName
FROM Member M, bookLoan bl
WHERE M.memberID = bl.memberID and bl.loanID IN (
    SELECT BLD.loanID 
    FROM bookLoanDetail bld, bookCopy bc,  Location L 
    WHERE bld.copyID = bc.copyID 
    and bc.locationID = L.locationID 
    and L.section = 'Văn học Việt Nam'
);

-- 15. Yêu cầu: Liệt kê những đầu sách chưa từng được mượn lần nào.
SELECT B.bookID, B.bookName, P.publisherName
FROM Book B, Publisher P
WHERE B.publisherID = P.publisherID and  B.bookID NOT IN (
    SELECT DISTINCT BC.bookID
    FROM bookCopy bc, bookLoanDetail bld
	where bc.copyID = bld.copyID
);

-- 16. Yêu cầu: Liệt kê các thành viên chưa bao giờ bị phạt.
SELECT M.memberID, M.memberName, M.status
FROM Member M
WHERE M.memberID NOT IN (
    SELECT DISTINCT bl.memberID
    FROM bookLoan bl, bookLoanDetail bld, Penalty P
    where bl.loanID = bld.loanID 
    and bld.loanDetailID = P.loanDetailID
);

-- 17. Yêu cầu: Tìm các bản sao sách hiện có sẵn (Available) thuộc thể loại 'Tiểu thuyết'.
SELECT bc.copyID, B.bookName,bc.bookCondition
FROM bookCopy bc, Book B
WHERE bc.bookID = B.bookID and BC.status = 'Available' AND B.bookTypeID IN (
    SELECT bookTypeID
    FROM bookType
    WHERE bookTypeName = 'Tiểu thuyết'
);

-- 18. Yêu cầu: Hiển thị lịch sử mượn sách của thành viên 'Nguyễn Văn An', bao gồm tên sách, ngày mượn, ngày trả.
SELECT B.bookName, bl.borrowDate, bld.returnDate
FROM Member M, bookLoan bl, 
    bookLoanDetail bld, bookCopy bc, Book B
where M.memberID = bl.memberID 
and bl.loanID = bld.loanID 
and bld.copyID = bc.copyID and bc.bookID = B.bookID
and M.memberName = 'Nguyễn Văn An'
ORDER BY BL.borrowDate DESC;

-- 19. Yêu cầu: Liệt kê các phiếu phạt được tạo ra do trả sách muộn, bao gồm tên thành viên và tên sách.
SELECT M.memberName, B.bookName, 
PI.fineAmountAtTime AS TienPhatTraMuon, P.issuedDate
FROM Penalty P, PenaltyItems PI, 
    bookLoanDetail BLD, bookLoan BL, 
    Member M, bookCopy BC, Book B
WHERE P.penaltyID = PI.penaltyID 
and P.loanDetailID = BLD.loanDetailID 
and BLD.loanID = BL.loanID and BL.memberID = M.memberID
and BLD.copyID = BC.copyID and BC.bookID = B.bookID 
and PI.violationCode = 'LATE_RETURN';

-- 20. Yêu cầu: Liệt kê thông tin các phiếu phạt chưa thanh toán, bao gồm tên thành viên, tên sách, các lý do phạt và tổng tiền.
SELECT 
    M.memberName, 
    B.bookName, 
    P.issuedDate, 
    P.totalFine,
    GROUP_CONCAT(FR.description SEPARATOR '; ') AS LyDoPhat
FROM Penalty P
JOIN bookLoanDetail BLD ON P.loanDetailID = BLD.loanDetailID
JOIN bookLoan BL ON BLD.loanID = BL.loanID
JOIN Member M ON BL.memberID = M.memberID
JOIN bookCopy BC ON BLD.copyID = BC.copyID
JOIN Book B ON BC.bookID = B.bookID
JOIN PenaltyItems PI ON P.penaltyID = PI.penaltyID
JOIN FineRates FR ON PI.violationCode = FR.violationCode
WHERE P.status = 'Unpaid'
GROUP BY P.penaltyID, M.memberName, B.bookName, P.issuedDate, P.totalFine;