# clarity_v

A new Flutter project.

# V_1
 - อัพเดตหน้าโปรเจคออกแบบโครงสร้าง

# V_2
 - อัพเดตหน้า Video_Screen

# V_3
 - ปรับแก้ไข icon หน้า Search
 - เพิ่มไอคอนหน้าของประเภทรถ
 - ปรับแก้การใส่เวลาให้มี 2 ช่วง

# V_4
 - ล็อกการย่อหน้าจอให้ไม่สามารถย่อไปมากกว่าเดิม

# V_5
 - อัพเดต Library การแสดงผลแบบ Percent 
 - ปรับ Layout การแสดงผลของหน้าค้นหาให้มีความเหมาะสม และปรับสมดุลการให้น้ำหนักการออกแบบ
 - ปรับ Layout การแสดงผลของหน้าผลการค้นหาให้มีการแบ่งสัดส่วน 40 / 60 ได้แก่ ฝั่งซ้าย(40)คือผลการค้นหาที่ใกล้เคียง และฝั่งขวา(60)คือผลการค้นหาที่ใกล้เคียงหรือเหมือนที่สุด
 - ปรับ Layout การแสดงผลของหน้าผลการตัดต่อให้มีการแบ่งสัดส่วน 40 / 60 ได้แก่ ฝั่งซ้าย(40)คือข้อมูลของรายละเอียดของรถที่ค้นหาได้จากหน้าผลการค้นหา และฝั่งขวา(60)คือผลการตัดต่อ
 - ทุกหน้ามีการปรับ Layout ให้มีความยืดหยุ่นในการใช้งานของสัดส่วนหน้าจอ ท่สามารถยืดและหดได้โดยไม่เสียโครงสร้างและจำกัดการย่อขนาดให้มีขีดจำกัดการย่อ

# V_6
 - เพิ่มฟังก์ชันให้มีการแสดงผลการวัดความเร็วโดยเฉลี่ยในหน้าผลการค้นหา
 - เพิ่มฟังก์ชันให้มีการแสดงผลการวัดความเร็วโดยเฉลี่ยในหน้าผลการตัดต่อ
 - มีการปรับ Layout เพิ่มเติมให้มีการปรับให้สมดุลมากขึ้น
# V_6.1
 - ปรับแก้ขนาดภาพหน้าผลการตัดต่อ

# V_7
 - แก้บัคเวลาให้มีการเลือกที่ต่างกันได้
 - แก้บัควันที่ให้ล็อกอยู่ที่ปัจจุบัน
 - ส่งค่าของเวลาเริ่มต้นไปเก็บไว้ใน List
 - ส่งค่าของเวลาสิ้นสุดไปเก็บไว้ใน List
 - ส่งค่าของของวันที่ไปเก็บไว้ใน List
 - ส่งค่าของสีที่เลือกไปเก็บไว้ใน List
 - ส่งค่าของป้ายทะเบียนไปเก็บไว้ใน List
 - ส่งค่าของจังหวัดไปเก็บไว้ใน List
 - ส่งค่าของประเภทรถไปเก็บไว้ใน List
 - รวม List ทั้งหมดเป็นข้อมูลเพื่อส่งต่อให้ API

# V_8
 - เพิ่มในส่วนของ Tooltip ให้กับ สีเพื่อบอกว่าสีนั้นคือสีอะไร
 - เพิ่มในส่วนของ Tooltip ให้กับ ประเภทของรถเพื่อบอกถึงประเภทของรถที่จะเลือก

# V_9
 - เพิ่มคำอธิบายกลุ่มของการทำงานต่างๆแบบภาพรวม
 - เพิ่มฟังก์ชันคลิ๊กแล้วปุ่มเปลี่ยนสี ที่ตำแหน่งปรพเภทของรถ

# V_9.1
 - ปรับแก้บัคการทำงานของปุ่มเพิ่มประเภทรถ ให้สามารถเพิ่มและลบออกได้
 - ปรับให้ปุ่มเพิ่มประเภทรถสามารถแสดงสีขณะเลือกให้มีความต่างออกไปได้
 - ปรับกาารนำเข้าข้อมูลก่อนส่งค่าให้กับ Back-End ให้มีการเพิ่มและลบออกได้ เพื่อลดการใส่ข้อมูลซ้ำซ้อน

# V_9.2
 - ปรับให้ปุ่มสีมีการแสดงผลที่หน้าหลักได้

# V_10
 - ปรับให้หน้าค้นหามีการส่งค่าออกมาทุกประเภทของรถหากไม่เลือกและปรับแก้การแสดงผลของสรุปการค้นหา
 - ปรับหน้าผลลัพธ์การค้นหา ให้สามารถกด Filter เพื่อเลือกประเภทรถได้อีกครั้งในการกรองข้อมูลอีกครั้ง
 - มีการปรับการเปลี่ยนแปลงค่าในหน้าผลลัพธ์การค้นหา เพื่อบันทึกค่าและมีการเรียกข้อมูลจาก Data Base
 - ปรับแก้หน้าผลการตัดต่อวีดีโอให้ใีการเชื่อมโยงข้อมูลกับหน้าการค้นหาหน้าแรก

# V_10.1
 - ปรับตำแหน่งของปุ่มแสดงตำแหน่งที่ตั้งของไฟล์
 - ปรับการทำงานการเลือกประเภทรถ

# V_11
 - เพิ่ม Model ของการเชื่อมต่อกับ API
 - เพิ่มการทำงานที่เชื่อมต่อกับ API เบื้องต้น


# V_11.1
 - ปรับรูปแบบการแสดงข้อมูลและการส่งค่าออกไป API

# V_11.2
 - ปรับรูปแบบหน้า UI ของหน้า ผลการค้นหา
 - ปรับรูปแบบหน้า UI ของหน้า ผลการตัดต่อ

# V_11.3
 - ปรับการโอนค่าของการเลือกรถ
 - ปรับแก้การโอนข้อมูลจากหน้าแรกไปหน้าสุดท้าย

# V_11.4
 - ปรับการออกแบบหน้า Video ให้แสดงภาพแทนและทำการคลิ๊กที่ภาพเพื่อไปยัง Web Browser
 - เพิ่มข้อความเพื่อให้ผู้ใช้เข้าใจ
 - เปลี่ยนชื่อปุ่มที่กดให้เป็นการ Download แทน

# V_11.5
 - ปิดการทำงานของการเชื่อมต่อ API ชั่วคราว 
 - ปรับสีและการแสดงผมในหน้า Video
 - ปรับวิธีการให้ผลลัพธ์ของ Video
 - เพิ่มความสามารถในการเข้าถึง Dir Path ของเครื่องได้
 - สามารถอ่านไฟล์และแสดงผลผ่านแอพตัวช่วงของอุปกรณ์ได้

# V_12
 - เปลี่ยนสีพื้นหลังทั้งหมด
 - ปรับแก้ธีมของสีที่ใช้
 - ปรับการแสดงผลของ UI บางส่วน
