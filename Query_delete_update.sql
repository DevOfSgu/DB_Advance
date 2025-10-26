-- 1. Cập nhật địa chỉ của nhà xuất bản
UPDATE Publisher
SET address = N'12 Nguyễn Trãi, Quận 5, TP.HCM'
WHERE publisherName = N'NXB Trẻ';

-- 2. Tăng giá thuê cho sách xuất bản trước năm 2015 thêm 10%
UPDATE Book
SET rentalPrice = rentalPrice * 1.1
WHERE PublishYear < 2015;

-- 3. Đổi trạng thái sách bị hỏng sang “Damaged”
UPDATE bookCopy
SET status = 'Damaged'
WHERE bookCondition = 'Damaged';

-- 4. Gia hạn ngày hết hạn thẻ thêm 1 năm cho thành viên đang “Active”
UPDATE Member
SET expiredDate = DATE_ADD(expiredDate, INTERVAL 1 YEAR)
WHERE status = 'Active';

-- 5. Cập nhật trạng thái phiếu phạt đã được thanh toán
UPDATE Penalty
SET status = 'Paid', processDate = CURDATE()
WHERE penaltyID = 3;
