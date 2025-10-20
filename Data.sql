use mg_library;

-- Dữ liệu mẫu cho bảng Publisher
INSERT INTO Publisher (publisherName, address) VALUES
('Nhà xuất bản Kim Đồng', '55 Quang Trung, Phường Nguyễn Du, Quận Hai Bà Trưng, Hà Nội'),
('Nhà xuất bản Trẻ', '161B Lý Chính Thắng, Phường Võ Thị Sáu, Quận 3, TP. Hồ Chí Minh'),
('Nhà xuất bản Giáo dục Việt Nam', '81 Trần Hưng Đạo, Phường Trần Hưng Đạo, Quận Hoàn Kiếm, Hà Nội'),
('Nhà xuất bản Phụ nữ Việt Nam', '39 Hàng Chuối, Phường Phạm Đình Hổ, Quận Hai Bà Trưng, Hà Nội'),
('Nhà xuất bản Văn học', '18 Nguyễn Trường Tộ, Phường Trúc Bạch, Quận Ba Đình, Hà Nội'),
('Nhã Nam', '59 Đỗ Quang, Phường Trung Hoà, Quận Cầu Giấy, Hà Nội'),
('Alpha Books', '138C Nguyễn Đình Chiểu, Phường 6, Quận 3, TP. Hồ Chí Minh'),
('Nhà xuất bản Hội Nhà văn', '65 P. Nguyễn Du, Bùi Thị Xuân, Quận Hai Bà Trưng, Hà Nội'),
('NXB Tổng hợp TP.HCM', '62 Nguyễn Thị Minh Khai, Phường Đa Kao, Quận 1, TP. Hồ Chí Minh'),
('First News - Trí Việt', '11H Nguyễn Thị Minh Khai, Phường Đa Kao, Quận 1, TP. Hồ Chí Minh');

-- Dữ liệu mẫu cho bảng Author
INSERT INTO Author (authorName) VALUES
('Nguyễn Nhật Ánh'),
('Tô Hoài'),
('Nam Cao'),
('J.K. Rowling'),
('Antoine de Saint-Exupéry'),
('Dale Carnegie'),
('Paulo Coelho'),
('Nguyễn Du'),
('Haruki Murakami'),
('Agatha Christie');

-- Dữ liệu mẫu cho bảng Location
INSERT INTO Location (shelf, section, description) VALUES
('VH-A-01', 'Văn học Việt Nam', 'Kệ A1, chứa các tác phẩm văn học Việt Nam hiện đại sau 1975.'),
('VH-A-02', 'Văn học Việt Nam', 'Kệ A2, chứa các tác phẩm văn học kinh điển và trung đại.'),
('VH-B-01', 'Văn học Nước ngoài', 'Kệ B1, chuyên tiểu thuyết kinh điển châu Âu và Mỹ.'),
('TN-C-01', 'Sách Thiếu nhi', 'Kệ C1, truyện cổ tích và ngụ ngôn cho lứa tuổi 5-10.'),
('TN-C-05', 'Sách Thiếu nhi', 'Kệ C5, khu vực truyện tranh Manga và Comic.'),
('KT-D-01', 'Kinh tế - Quản trị', 'Kệ D1, sách về kinh tế học, quản trị kinh doanh và marketing.'),
('KN-E-01', 'Kỹ năng sống - Self-help', 'Kệ E1, sách phát triển bản thân, kỹ năng mềm và giao tiếp.'),
('KH-F-01', 'Khoa học - Kỹ thuật', 'Kệ F1, sách khoa học thường thức, công nghệ và máy tính.'),
('LS-G-01', 'Lịch sử - Xã hội', 'Kệ G1, sách lịch sử Việt Nam và thế giới.'),
('TK-H-01', 'Sách Tham khảo', 'Kệ H1, chứa từ điển, bách khoa toàn thư. Chỉ đọc tại chỗ.');

-- Dữ liệu mẫu cho bảng BookType
INSERT INTO bookType (bookTypeName) VALUES
('Tiểu thuyết'),
('Truyện ngắn'),
('Sách Thiếu nhi'),
('Truyện tranh'),
('Kỹ năng sống'),
('Kinh tế - Quản trị'),
('Lịch sử'),
('Khoa học viễn tưởng'),
('Trinh thám'),
('Tâm lý học');

-- -- Dữ liệu mẫu cho bảng Book
INSERT INTO Book (bookName, PublishYear, rentalPrice, publisherID) VALUES
('Cho tôi xin một vé đi tuổi thơ', 2008, 15000, 2), -- NXB Trẻ
('Dế Mèn phiêu lưu ký', 2018, 12000, 1), -- NXB Kim Đồng
('Harry Potter và Hòn đá Phù thủy', 2017, 25000, 2), -- NXB Trẻ
('Hoàng tử bé', 2019, 10000, 6), -- Nhã Nam
('Lão Hạc (Tuyển tập truyện ngắn)', 2015, 8000, 5), -- NXB Văn học
('Đắc nhân tâm', 2020, 18000, 7), -- Alpha Books
('Nhà giả kim', 2018, 16000, 6), -- Nhã Nam
('Rừng Na Uy', 2016, 22000, 6), -- Nhã Nam
('Án mạng trên sông Nile', 2019, 17000, 2), -- NXB Trẻ
('Mắt biếc', 2019, 15000, 2); -- NXB Trẻ

-- Dữ liệu mẫu cho bảng BookCopy
INSERT INTO bookCopy (bookID, locationID, bookCondition, status) VALUES
-- 5 bản sao cho 'Cho tôi xin một vé đi tuổi thơ' (bookID=1) - Khu VH Việt Nam
(1, 1, 'New', 'Available'),
(1, 1, 'New', 'Available'),
(1, 1, 'Good', 'Rented'),
(1, 1, 'Good', 'Available'),
(1, 1, 'Fair', 'Available'),

-- 5 bản sao cho 'Dế Mèn phiêu lưu ký' (bookID=2) - Khu Thiếu nhi
(2, 4, 'New', 'Available'),
(2, 4, 'New', 'Available'),
(2, 4, 'New', 'Available'),
(2, 4, 'Good', 'Rented'),
(2, 4, 'Good', 'Available'),

-- 5 bản sao cho 'Harry Potter...' (bookID=3) - Khu VH Nước ngoài
(3, 3, 'New', 'Available'),
(3, 3, 'New', 'Rented'),
(3, 3, 'Good', 'Available'),
(3, 3, 'Good', 'Available'),
(3, 3, 'Fair', 'Available'),

-- 5 bản sao cho 'Hoàng tử bé' (bookID=4) - Khu VH Nước ngoài
(4, 3, 'New', 'Available'),
(4, 3, 'New', 'Available'),
(4, 3, 'Good', 'Available'),
(4, 3, 'Good', 'Available'),
(4, 3, 'Good', 'Available'),

-- 5 bản sao cho 'Lão Hạc' (bookID=5) - Khu VH Việt Nam
(5, 2, 'Good', 'Available'),
(5, 2, 'Good', 'Available'),
(5, 2, 'Fair', 'Rented'),
(5, 2, 'Fair', 'Available'),
(5, 2, 'Fair', 'Available'),

-- 5 bản sao cho 'Đắc nhân tâm' (bookID=6) - Khu Kỹ năng sống
(6, 7, 'New', 'Available'),
(6, 7, 'New', 'Rented'),
(6, 7, 'New', 'Available'),
(6, 7, 'Good', 'Available'),
(6, 7, 'Good', 'Rented'),

-- 5 bản sao cho 'Nhà giả kim' (bookID=7) - Khu VH Nước ngoài
(7, 3, 'New', 'Available'),
(7, 3, 'New', 'Available'),
(7, 3, 'Good', 'Rented'),
(7, 3, 'Good', 'Available'),
(7, 3, 'Good', 'Available'),

-- 5 bản sao cho 'Rừng Na Uy' (bookID=8) - Khu VH Nước ngoài
(8, 3, 'Good', 'Available'),
(8, 3, 'Good', 'Rented'),
(8, 3, 'Good', 'Available'),
(8, 3, 'Good', 'Available'),
(8, 3, 'Fair', 'Available'),

-- 5 bản sao cho 'Án mạng trên sông Nile' (bookID=9) - Khu VH Nước ngoài
(9, 3, 'New', 'Available'),
(9, 3, 'New', 'Available'),
(9, 3, 'Good', 'Rented'),
(9, 3, 'Good', 'Available'),
(9, 3, 'Good', 'Available'),

-- 5 bản sao cho 'Mắt biếc' (bookID=10) - Khu VH Việt Nam
(10, 1, 'New', 'Available'),
(10, 1, 'New', 'Rented'),
(10, 1, 'New', 'Available'),
(10, 1, 'Good', 'Available'),
(10, 1, 'Good', 'Available');

-- Dữ liệu mẫu cho bảng Book Author
-- Liên kết mỗi cuốn sách với tác giả tương ứng
INSERT INTO book_Author (bookID, authorID) VALUES
-- Các sách có 1 tác giả
(1, 1),  -- 'Cho tôi xin một vé đi tuổi thơ' - Nguyễn Nhật Ánh
(2, 2),  -- 'Dế Mèn phiêu lưu ký' - Tô Hoài
(3, 4),  -- 'Harry Potter và Hòn đá Phù thủy' - J.K. Rowling
(4, 5),  -- 'Hoàng tử bé' - Antoine de Saint-Exupéry
(5, 3),  -- 'Lão Hạc' - Nam Cao
(6, 6),  -- 'Đắc nhân tâm' - Dale Carnegie
(7, 7),  -- 'Nhà giả kim' - Paulo Coelho
(8, 9),  -- 'Rừng Na Uy' - Haruki Murakami
(9, 10), -- 'Án mạng trên sông Nile' - Agatha Christie
(10, 1), -- 'Mắt biếc' - Nguyễn Nhật Ánh (Tác giả Nguyễn Nhật Ánh có 2 sách)
-- Giả sử sách 'Đắc nhân tâm' có thêm một người biên soạn/hiệu đính chính
(6, 7);  -- 'Đắc nhân tâm' cũng được liên kết với Paulo Coelho (minh họa sách có nhiều tác giả)

-- Dữ liệu mẫu cho bảng book Booktype
INSERT INTO book_Booktype (bookID, bookTypeID) VALUES
-- Cho tôi xin một vé đi tuổi thơ (Tiểu thuyết, Sách Thiếu nhi)
(1, 1),
(1, 3),

-- Dế Mèn phiêu lưu ký (Tiểu thuyết, Sách Thiếu nhi)
(2, 1),
(2, 3),

-- Harry Potter và Hòn đá Phù thủy (Tiểu thuyết, Khoa học viễn tưởng/Fantasy)
(3, 1),
(3, 8),

-- Hoàng tử bé (Tiểu thuyết, Sách Thiếu nhi)
(4, 1),
(4, 3),

-- Lão Hạc (Tuyển tập truyện ngắn)
(5, 2),

-- Đắc nhân tâm (Kỹ năng sống, Tâm lý học)
(6, 5),
(6, 10),

-- Nhà giả kim (Tiểu thuyết)
(7, 1),

-- Rừng Na Uy (Tiểu thuyết, Tâm lý học)
(8, 1),
(8, 10),

-- Án mạng trên sông Nile (Tiểu thuyết, Trinh thám)
(9, 1),
(9, 9),

-- Mắt biếc (Tiểu thuyết)
(10, 1);

-- Dữ liệu mẫu cho bảng Member
INSERT INTO Member (memberName, memberDate, memberLocation, memberPhoneNumber, memberEmail, createCardDate, expiredDate, status) VALUES
('Nguyễn Văn An', '1990-05-15', '123 Đường Láng, Đống Đa, Hà Nội', '0987654321', 'an.nguyen@example.com', '2023-01-10', '2024-01-10', 'Active'),
('Trần Thị Bích', '1985-11-20', '45 Nguyễn Trãi, Quận 1, TP. Hồ Chí Minh', '0912345678', 'bich.tran@example.com', '2022-11-05', '2023-11-05', 'Inactive'),
('Lê Minh Cường', '2002-01-30', '25 Hàng Bông, Hoàn Kiếm, Hà Nội', '0334567890', 'cuong.le@example.com', '2023-08-20', '2024-08-20', 'Active'),
('Phạm Thu Hà', '1998-07-22', '789 CMT8, Quận 10, TP. Hồ Chí Minh', '0868123456', 'ha.pham@example.com', '2023-03-15', '2024-03-15', 'Active'),
('Hoàng Đức Anh', '1978-03-12', '10 Cầu Giấy, Cầu Giấy, Hà Nội', '0905111222', 'anh.hoang@example.com', '2021-06-01', '2022-06-01', 'Expired'),
('Vũ Ngọc Mai', '2005-09-01', '55 Võ Văn Tần, Quận 3, TP. Hồ Chí Minh', '0399888777', 'mai.vu@example.com', '2023-09-05', '2024-09-05', 'Active'),
('Đặng Tuấn Kiệt', '1995-04-18', '321 Bạch Mai, Hai Bà Trưng, Hà Nội', '0944555666', 'kiet.dang@example.com', '2022-07-25', '2023-07-25', 'Active'),
('Bùi Thanh Trúc', '1999-08-08', '99 Pasteur, Quận 1, TP. Hồ Chí Minh', '0833222111', 'truc.bui@example.com', '2023-05-30', '2024-05-30', 'Active'),
('Doãn Quốc Đam', '1982-12-25', '88 Kim Mã, Ba Đình, Hà Nội', '0977333444', 'dam.doan@example.com', '2021-02-28', '2022-02-28', 'Expired'),
('Ngô Bảo Châu', '2000-02-14', '22 Bùi Viện, Quận 1, TP. Hồ Chí Minh', '0355999000', 'chau.ngo@example.com', '2022-10-10', '2023-10-10', 'Active');

-- Dữ liệu mẫu cho bảng Librarian
INSERT INTO Librarian (librarianName, librarianDate, librarianPhoneNumber) VALUES
('Nguyễn Thu Trang', '1988-09-21', '0912345670'),
('Lê Văn Minh', '1975-02-10', '0987654320'),
('Trần Hoàng Long', '1995-06-18', '0334455667'),
('Phạm Ngọc Ánh', '2000-11-03', '0868112233'),
('Vũ Đức Bảo', '1992-04-25', '0905987654');

-- Dữ liệu mẫu cho bảng bookLoans
INSERT INTO bookLoans (memberID, librarianID, borrowDate, dueDate, status) VALUES
-- Tình huống 1: Phiếu đang mượn, còn hạn
(1, 1, CURDATE() - INTERVAL 7 DAY, CURDATE() + INTERVAL 7 DAY, 'Borrowed'),

-- Tình huống 2: Phiếu quá hạn (liên kết với thành viên Inactive)
(2, 2, CURDATE() - INTERVAL 30 DAY, CURDATE() - INTERVAL 16 DAY, 'Overdue'),

-- Tình huống 3: Phiếu đã trả trong quá khứ
(3, 3, '2023-09-01', '2023-09-15', 'Returned'),

-- Tình huống 4: Phiếu đã trả gần đây
(4, 4, CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 6 DAY, 'Returned'),

-- Tình huống 5: Phiếu vừa mượn hôm qua
(6, 5, CURDATE() - INTERVAL 1 DAY, CURDATE() + INTERVAL 13 DAY, 'Borrowed'),

-- Tình huống 6: Một phiếu đã trả khác của thành viên active
(7, 1, '2023-08-15', '2023-08-29', 'Returned'),

-- Tình huống 7: Phiếu vừa mượn hôm nay
(8, 2, CURDATE(), CURDATE() + INTERVAL 14 DAY, 'Borrowed'),

-- Tình huống 8: Phiếu cũ của thành viên đã hết hạn thẻ (nhưng đã trả)
(9, 3, '2022-01-10', '2022-01-24', 'Returned'),

-- Tình huống 9: Thành viên 1 có một phiếu mượn khác đã trả
(1, 4, '2023-07-01', '2023-07-15', 'Returned'),

-- Tình huống 10: Phiếu đang mượn, còn hạn
(10, 5, CURDATE() - INTERVAL 5 DAY, CURDATE() + INTERVAL 9 DAY, 'Borrowed');

-- Dữ liệu mẫu cho bảng bookLoans_detail
INSERT INTO bookLoans_detail (loanID, copyID, returnDate, bookConditionOut, bookConditionIn) VALUES
-- Chi tiết cho loanID = 1 (Đang mượn)
(1, 3, NULL, 'Good', NULL),  -- Mượn cuốn 'Cho tôi xin một vé đi tuổi thơ'
(1, 47, NULL, 'New', NULL), -- Mượn cuốn 'Mắt biếc'

-- Chi tiết cho loanID = 2 (Quá hạn)
(2, 9, NULL, 'Good', NULL),  -- Mượn cuốn 'Dế Mèn phiêu lưu ký'

-- Chi tiết cho loanID = 3 (Đã trả)
(3, 6, '2023-09-14', 'New', 'New'), -- Trả cuốn 'Dế Mèn phiêu lưu ký'
(3, 11, '2023-09-14', 'New', 'New'),-- Trả cuốn 'Harry Potter...'

-- Chi tiết cho loanID = 4 (Đã trả, nhưng trả muộn và làm hỏng sách)
(4, 13, CURDATE() - INTERVAL 4 DAY, 'Good', 'Damaged'), -- Trả cuốn 'Harry Potter...'

-- Chi tiết cho loanID = 5 (Đang mượn)
(5, 20, NULL, 'Good', NULL), -- Mượn cuốn 'Hoàng tử bé'

-- Chi tiết cho loanID = 6 (Đã trả)
(6, 31, '2023-08-28', 'New', 'New'), -- Trả cuốn 'Nhà giả kim'

-- Chi tiết cho loanID = 7 (Đang mượn)
(7, 41, NULL, 'New', NULL), -- Mượn cuốn 'Án mạng trên sông Nile'
(7, 21, NULL, 'Good', NULL),-- Mượn cuốn 'Lão Hạc'

-- Chi tiết cho loanID = 8 (Đã trả)
(8, 26, '2022-01-20', 'New', 'New'), -- Trả cuốn 'Đắc nhân tâm'

-- Chi tiết cho loanID = 9 (Đã trả)
(9, 1, '2023-07-15', 'New', 'New'), -- Trả cuốn 'Cho tôi xin một vé đi tuổi thơ'

-- Chi tiết cho loanID = 10 (Đang mượn)
(10, 37, NULL, 'Good', NULL); -- Mượn cuốn 'Rừng Na Uy'