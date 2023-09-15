// SPDX-License-Identifier: MIT
pragma solidity >=0.5.22 <0.9.0;

contract UniversityAuthentication {

    // 1. การกำหนดบทบาท
    enum Role { Student, Teacher, Admin }

    // สร้างโครงสร้างสำหรับผู้ใช้ที่มีรหัสผ่านและบทบาท
    struct User {
        string password;
        Role role;
    }

    // การสร้าง mapping ระหว่างชื่อผู้ใช้และข้อมูลผู้ใช้
    mapping(string => User) users;

    // ตัวแปรสำหรับเก็บ address ของแอดมิน
    address public admin;

    // Modifier ที่ใช้ตรวจสอบว่าผู้ที่ร้องขอเป็นแอดมินหรือไม่
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Constructor สำหรับกำหนดค่าเริ่มต้นของแอดมิน
    constructor() {
        admin = msg.sender;
    }

    // 2. ฟังก์ชันสำหรับสร้างบัญชีผู้ใช้
    function createUser(string memory _username, string memory _password, Role _role) public onlyAdmin {
        users[_username] = User(_password, _role);
    }

    // 3. ฟังก์ชันสำหรับเปลี่ยนรหัสผ่านของผู้ใช้
    function changePassword(string memory _username, string memory _newPassword) public {
        require(keccak256(abi.encodePacked(users[_username].password)) == keccak256(abi.encodePacked(_newPassword)), "Incorrect password");
        users[_username].password = _newPassword;
    }

    // 4. ฟังก์ชันสำหรับเข้าสู่ระบบ
    function login(string memory _username, string memory _password) public view returns (Role) {
        require(keccak256(abi.encodePacked(users[_username].password)) == keccak256(abi.encodePacked(_password)), "Incorrect username or password");
        return users[_username].role;
    }
}
