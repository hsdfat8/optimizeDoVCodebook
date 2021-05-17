# optimizeDoVCodebook
## Lý thuyết:

**Mục tiêu của bài toán:** Gen 1 tập hình dạng sóng đảm bảo **đủ khác nhau** để thực hiện mã hóa dữ liệu thành dạng sóng truyền đi trên kênh truyền AMR-WB.

Sóng được sinh ra là tổng của các sóng sin với những tần số khác nhau.
Tối ưu các tham số để giá tr tương quan giữa 2 sóng khác nhau bất kì là 0.

Lý thuyết rõ hơn:

Các tham số dùng chính dùng trong code:


|Tham số|Ý nghĩa|
|-|-|
|m|Số sóng wave form cần gen|
|n|Số mẫu trong 1 sóng sin|
|fs|Tần số lấy mẫu|
|q|Số sóng mang con|
|f0|Tần số base|
|deltaf|Tần số bước nhảy|

Tối ưu theo các tham số m,n,q,deltaf. Tối ưu nhất là chọn q = m/2, deltaf= fs/2/n.

Code:
|Hàm|Ý nghĩa|
|-|-|
|OptimizeCodeBook|Gen codebook tối ưu|
|mapCodebook| Ánh xạ bit sang dạng sóng|
|demapCodebook| Ánh xạ dạng sóng về chuỗi bit|
|cosC|Hàm tính độ giống nhau giữa các waveform|

## Mô phỏng
Mô phỏng trên kênh truyền AMR-WB giữa các mode.
Bộ tham số tối ưu cho dataRate = 8000/6 (90 bit ứng với frame 67.5ms giọng nói):



|m|n|f0|deltaf|q|mode|BER|
|-|-|-|-|-|-|-|
|8|18|444.44 Hz|222.22 Hz|4|0|8%|
|8|18|444.44 Hz|222.22 Hz|4|1|0.7%|
|16|24|333.33 Hz|222.22 Hz|8|0|8%|
|16|24|333.33 Hz|166.67 Hz|8|1|0.7%|
