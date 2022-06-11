package com.fzu.inventory_assistant.utils.BizException;

import lombok.Data;
@Data
public class BizException extends RuntimeException {

    private static final long serialVersionUID = -7864604160297181941L;

    /** 错误码 */
    protected final ErrorCode errorCode;

    private String code;

    public BizException() {
        super(BizErrorCodeEnum.UNSPECIFIED.getDescription());
        this.errorCode = BizErrorCodeEnum.UNSPECIFIED;
    }

    public BizException(final ErrorCode errorCode) {
        super(errorCode.getDescription());
        this.errorCode = errorCode;
    }

    public BizException(final String detailedMessage) {
        super(detailedMessage);
        this.errorCode = BizErrorCodeEnum.UNSPECIFIED;
    }

    public BizException(final ErrorCode errorCode, final String detailedMessage) {
        super(detailedMessage);
        this.errorCode = errorCode;
    }

    public ErrorCode getErrorCode() {
        return errorCode;
    }


}