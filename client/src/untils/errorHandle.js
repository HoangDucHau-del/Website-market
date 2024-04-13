module.exports = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500; // trả về mã lỗi 500 nếu không có status code được trả về
    err.message = err.message || 'server error'; //

    return res.status(err.statusCode).json({
        statusCode: err.statusCode,
        message: err.message,
    });
};
