-- 1. Yêu cầu: Đếm số lượng đầu sách của mỗi nhà xuất bản
select	p.publisherName, count(b.bookID) as total_book
from publisher p, book b
where p.publisherID = b.publisherID
group by p.publisherID;

-- 2. Yêu cầu: Tính tổng số tiền phạt chưa thanh toán (Unpaid) của mỗi thành viên.
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
-- 3. Yêu cầu: Tìm giá thuê cao nhất, thấp nhất và trung bình của các đầu sách được xuất bản bởi 'Nhà xuất bản Trẻ'.

-- 4. Yêu cầu: Đếm số lượng sách đã mượn (bao gồm cả đang mượn và đã trả) của mỗi thành viên.

-- 5. Yêu cầu: Đếm tổng số bản sao sách (bookCopy) theo từng tác giả.

-- 6. Yêu cầu: Tính tổng số lượt tạo phiếu mượn được thực hiện bởi mỗi thủ thư.

-- 7. Yêu cầu: Liệt kê các tác giả có từ 2 đầu sách trở lên trong thư viện.

-- 8. Yêu cầu: Tìm những thành viên đã mượn sách từ 3 lần trở lên.

-- 9. Yêu cầu: Liệt kê các đầu sách được mượn nhiều hơn 2 lần.

-- 10. Yêu cầu: Liệt kê các nhà xuất bản có tổng số sách trong thư viện nhiều hơn 5 bản sao (bookCopy).