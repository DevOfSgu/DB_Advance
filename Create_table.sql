use mg_library;

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
    shelf nvarchar(50) NOT NULL UNIQUE,
    section nvarchar(100),
    description nvarchar(255)
);

create table bookType(
	bookTypeID int auto_increment primary key,
    bookTypeName nvarchar(100) not null
);

create table Book(
	bookID int auto_increment primary key ,
    bookName nvarchar(100) not null,
    PublishYear int,
    Price decimal(10, 0),    
    publisherID int,
    foreign key (publisherID) references Publisher(publisherID) ON DELETE CASCADE
);

create table bookCopy(
	copyID int auto_increment primary key, 
    bookID int,
    locationID int,
    status ENUM('Available', 'On Loan', 'Damaged', 'Lost') default 'Available' ,
    foreign key (bookID) references Book(bookID) ON DELETE CASCADE,
    foreign key (locationID) references Location(locationID) ON DELETE CASCADE
 );

create table book_Author(
	bookID int,
    authorID int,
	primary key (bookID, authorID),
    foreign key (bookID) references Book(bookID) ON DELETE CASCADE,
    foreign key (authorID) references Author(authorID) ON DELETE CASCADE
);

create table book_Booktype(
	bookID int,
    bookTypeID int,
    primary key (bookID, bookTypeID),
    foreign key (bookID) references Book(bookID) ON DELETE CASCADE,
    foreign key (bookTypeID) references bookType(bookTypeID) ON DELETE CASCADE
);
	
create table Member(
	memberID int auto_increment primary key,
    memberName nvarchar(50) not null,
    memberDate date,
    memberLocation nvarchar(100),
    memberPhoneNumber varchar(10) not null unique,
    memberEmail varchar(50) unique,
    createCardDate date not null default (curdate()),
    expiredDate date,
    status ENUM('Active', 'Expired', 'Suspended') default 'Active'
);

create table Librarian(
	librarianID int auto_increment primary key,
    librarianName nvarchar(50) not null,
    librarianDate date,
    librarianPhoneNumber varchar(10) not null unique
);

create table bookLoans(
	loanID int auto_increment primary key,
    memberID int, 
    librarianID int,
    borrowDate date,
    dueDate date,
    status ENUM('Borrowed', 'Returned', 'Overdue') default 'Borrowed',
    foreign key (memberID) references Member(memberID) ON DELETE SET NULL,
    foreign key (librarianID) references Librarian(librarianID) ON DELETE CASCADE
);

create table bookLoans_detail(
	loanDetailID int auto_increment primary key,
	loanID int,
    copyID int,
    returnDate date,
	bookConditionOut nvarchar(100),
    bookConditionIn nvarchar(100),
    foreign key (loanID) references bookLoans(loanID) ON DELETE CASCADE,
    foreign key (copyID) references bookCopy(copyID) ON DELETE CASCADE,
    unique key uk_loan_copy (loanID, copyID)
);

create table Penalty(
	penaltyID int auto_increment primary key,
    loanDetailID int,
    reason nvarchar(100),
    fine decimal(10, 0), 
    processDate date,
    status ENUM('Unpaid', 'Paid') default 'Unpaid',
    foreign key (loanDetailID) references bookloans_detail(loanDetailID) ON DELETE CASCADE    
);