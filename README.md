# intro_dio
credit : https://www.youtube.com/watch?v=O4KtRPrBALQ&t=353s
## api from jsonplaceholder
https://jsonplaceholder.typicode.com/posts
## Dio Started 
page ไปเรียก service <br />
service ไปเรียก API (Dio) มายัดใส่ Model แล้วจึงโยนกลับไปที่ application <br />
ซึ่งเป็นการ decompose ให้ application architecture ของเราดีขึ้น <br />
* สร้าง API เป็นแบบ Singleton <br />
## Service is singleton

# note
initState() จะต้องเป็น synchronous  เท่านั้น <br />
แต่ตัว Service เป็น asynchronous หรือ เป็น Future เราจึงต้องสร้าง method ที่เป็น asynchronous แล้วนำไปเรียกใช้ที่ initState() <br />

# fpdart
* Either จะ return เป็น Model หรือ Error
ถ้าสำเร็จจะ return ด้วย left
ถ้า error จะ return right
ฟังก์ชั่น .fold เป็นการบอกว่าถ้ามีข้อมูลทาง ซ้ายและขวา ให้แยกกันทำอะไรบ้าง ?