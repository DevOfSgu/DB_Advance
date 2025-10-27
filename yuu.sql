use library_management;

-- update status penalty
UPDATE Penalty 
SET status = 'Paid' 
WHERE penaltyID IN (1, 2, 3, 4, 5);

-- 11. Yêu cầu: Tìm những ngày có hơn 1 phiếu mượn được tạo và thủ thư thực hiện là 'Hoàng Thị Lan'.

-- 12. Yêu cầu: Liệt kê các thành viên có tổng số tiền phạt (chưa tính đã trả hay chưa) lớn hơn 50000.

-- 13. Yêu cầu: Tìm tất cả các bản sao sách (bookCopy) của tác giả 'Nguyễn Nhật Ánh'.

-- 14. Yêu cầu: Liệt kê các thành viên đang mượn sách thuộc khu vực 'Văn học Việt Nam'.

-- 15. Yêu cầu: Liệt kê những đầu sách chưa từng được mượn lần nào.

-- 16. Yêu cầu: Liệt kê các thành viên chưa bao giờ bị phạt.

-- 17. Yêu cầu: Tìm các bản sao sách hiện có sẵn (Available) thuộc thể loại 'Tiểu thuyết'.

-- 18. Yêu cầu: Hiển thị lịch sử mượn sách của thành viên 'Nguyễn Văn An', bao gồm tên sách, ngày mượn, ngày trả.

-- 19. Yêu cầu: Liệt kê chi tiết các phiếu mượn đang quá hạn, bao gồm tên thành viên, tên sách, và số ngày quá hạn.

-- 20. Yêu cầu: Liệt kê thông tin các phiếu phạt chưa thanh toán, bao gồm tên thành viên, tên sách, lý do và số tiền phạt.
