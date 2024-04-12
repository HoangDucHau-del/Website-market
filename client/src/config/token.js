const jwt = require('jsonwebtoken');
require('dotenv').config();

// Tạo access token và refresh token
// refresh token có chức năng làm chìa khóa để tạo lại access token sau mỗi lần access token hết hạn
module.exports.token = {
    accessToken: (data) =>
        jwt.sign(
            { iduser: data.iduser, email: data.email }, // dữ liệu được mã hóa trong token
            process.env.JWT_ACCESS_KEY, // Mã khóa để tạo token (secret key)
            {
                expiresIn: '60s', // Thời gian hết hạn của token
            }
        ),
    refreshToken: (data) =>
        jwt.sign(
            { iduser: data.iduser, email: data.email },
            process.env.JWT_REFRESH_KEY,
            {
                expiresIn: '365d',
            }
        ),
};

// Hàm kiểm tra token hết hạn hay chưa
module.exports.isTokenExpried = (token) => {
    const decodeToken = jwt.decode(token);
    const expirationTime = decodeToken.exp * 1000;
    const currentTime = Date.now().valueOf() / 1000;
    return expirationTime > currentTime;
};
