package cn.brath.utils;

/***
 * @Auther: Brath
 * Create By Brath on 2022/4/6 13:18
 * Strive to create higher performance code
 * @My wechat: 17604868415
 * @My QQ: 2634490675
 * @My email 1: email_ guoqing@163.com
 * @My email 2: enjoy_ light_ sports@163.com
 * @Program body: interview-spring-cloud-alibaba
 * 接口枚举信息的响应
 */
public enum ResponseCode {

    /***
     * 通用返回信息枚举
     */
    SYSTEM_EXCEPTION(500, "系统错误"),
    DATA_DOES_NOT_EXIST(200, "数据不存在!");


    private final Integer code;
    private final String desc;

    ResponseCode(Integer code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static ResponseCode getInstance(Integer code) {
        if (code != null) {
            for (ResponseCode tmp : ResponseCode.values()) {
                if (tmp.code.intValue() == code.intValue()) {
                    return tmp;
                }
            }
        }
        return null;
    }

    public Integer code() {
        return code;
    }

    public String desc() {
        return desc;
    }

}
