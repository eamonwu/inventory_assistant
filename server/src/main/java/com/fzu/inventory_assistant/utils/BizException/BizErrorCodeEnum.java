package com.fzu.inventory_assistant.utils.BizException;

/**
 * Description:
 * User: Haibara
 * Date: 2022-3-10
 * Time: 11:30
 */

public enum BizErrorCodeEnum implements ErrorCode {

    /** 未指明的异常 */
    PARAM_MISTAKE(400,"参数错误"),
    UNAUTHORIZED(401,"用户信息验证失败"),
    NOT_FOUND(404,"无法找到请求资源"),
    UNSPECIFIED(500, "未知异常，服务端出现错误"),

    /** 用户登录异常 **/
    USER_NOT_EXIST(4001,"用户不存在"),
    USER_PASSWORD_ERROR(4002,"密码错误"),
    USER_IN_BLOCK(4003,"用户被冻结"),

    /** 用户登录异常 **/
    USER_ACCOUNT_EXIST(4004,"账号已被注册"),
    USER_EMAIL_EXIST(4005,"邮箱已被注册"),


    /**文章操作异常**/
    GOODS_NOT_EXIST(4004,"物品不存在"),
    ;

    /** 错误码 */
    private final Integer code;

    /** 描述 */
    private final String description;

    /**
     * @param code 错误码
     * @param description 描述
     */
    private BizErrorCodeEnum(final Integer code, final String description) {
        this.code = code;
        this.description = description;
    }

    /**
     * 根据编码查询枚举。
     *
     * @param code 编码。
     * @return 枚举。
     */
    public static BizErrorCodeEnum getByCode(Integer code) {
        for (BizErrorCodeEnum value : BizErrorCodeEnum.values()) {
            if (code.equals(value.getCode())) {
                return value;
            }
        }
        return UNSPECIFIED;
    }

    /**
     * 枚举是否包含此code
     * @param code 枚举code
     * @return 结果
     */
    public static Boolean contains(Integer code){
        for (BizErrorCodeEnum value : BizErrorCodeEnum.values()) {
            if (code.equals(value.getCode())) {
                return true;
            }
        }
        return  false;
    }

    @Override
    public Integer getCode() {
        return code;
    }

    @Override
    public String getDescription() {
        return description;
    }
}