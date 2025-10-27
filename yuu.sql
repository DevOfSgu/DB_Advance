use library_management;

-- update status penalty
UPDATE Penalty 
SET status = 'Paid' 
WHERE penaltyID IN (1, 2, 3, 4, 5);

-- 1. Yêu cầu: Đếm số lượng đầu sách của mỗi nhà xuất bản
select	p.publisherName, count(b.bookID) as total_book
from publisher p, book b
where p.publisherID = b.publisherID
group by p.publisherID;

-- 2. Tính tổng số tiền phạt chưa thanh toán (Unpaid) của mỗi thành viên.
SELECT 
    M.memberName,
    SUM(P.totalFine) AS TongTienPhatChuaThanhToan
FROM Member M
JOIN bookLoan BL ON M.memberID = BL.memberID
JOIN bookLoanDetail BLD ON BL.loanID = BLD.loanID
JOIN Penalty P ON BLD.loanDetailID = P.loanDetailID
WHERE P.status = 'Unpaid'
GROUP BY M.memberName
ORDER BY TongTienPhatChuaThanhToan DESC;

-- 7. Yêu cầu: Liệt kê các tác giả có từ 2 đầu sách trở lên trong thư viện.


-- 8. Yêu cầu: Tìm những thành viên đã mượn sách từ 3 lần trở lên.

-- 9. Yêu cầu: Liệt kê các đầu sách được mượn nhiều hơn 2 lần.

-- 12. Yêu cầu: Liệt kê các thành viên có tổng số tiền phạt (chưa tính đã trả hay chưa) lớn hơn 50000.

-- 15. Yêu cầu: Liệt kê những đầu sách chưa từng được mượn lần nào.

-- 18. Yêu cầu: Hiển thị lịch sử mượn sách của thành viên 'Nguyễn Văn An', bao gồm tên sách, ngày mượn, ngày trả.

-- 19. Yêu cầu: Liệt kê chi tiết các phiếu mượn đang quá hạn, bao gồm tên thành viên, tên sách, và số ngày quá hạn.

-- 20. Yêu cầu: Liệt kê thông tin các phiếu phạt chưa thanh toán, bao gồm tên thành viên, tên sách, lý do và số tiền phạt.
