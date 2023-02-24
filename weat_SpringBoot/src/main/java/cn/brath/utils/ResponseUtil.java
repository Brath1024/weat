package cn.brath.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/***
 * 响应操作结果
 *
 * <pre>
 *  {
 *      errno： 错误码，
 *      errmsg：错误消息，
 *      data：  响应数据
 *  }
 * </pre>
 *
 * <p>
 * 错误码：
 * <ul>
 * <li>0，成功；
 * <li>4xx，前端错误，说明前端开发者需要重新了解后端接口使用规范：
 * <ul>
 * <li>401，参数错误，即前端没有传递后端需要的参数；
 * <li>402，参数值错误，即前端传递的参数值不符合后端接收范围。
 * </ul>
 * <li>5xx，后端错误，除501外，说明后端开发者应该继续优化代码，尽量避免返回后端错误码：
 * <ul>
 * <li>501，验证失败，即后端要求用户登录；
 * <li>502，系统内部错误，即没有合适命名的后端内部错误；
 * <li>503，业务不支持，即后端虽然定义了接口，但是还没有实现功能；
 * <li>504，更新数据失效，即后端采用了乐观锁更新，而并发更新时存在数据更新失效；
 * <li>505，更新数据失败，即后端数据库更新失败（正常情况应该更新成功）。
 * </ul>
 * <li>6xx，后端业务错误码， 具体见Esn-admin-api模块的AdminResponseCode。
 * <li>7xx，管理后台后端业务错误码， 具体见Esn-wx-api模块的WxResponseCode。
 * </ul>
 * @Auther: Brath
 * Create By Brath on 2022/3/25 8:44
 * Strive to create higher performance code
 * @My wechat: 17604868415
 * @My QQ: 2634490675
 * @My email 1: email_ guoqing@163.com
 * @My email 2: enjoy_ light_ sports@163.com
 * @Program body: interview-spring-cloud-alibaba
 */
public class ResponseUtil {

    public static final int SUCCESS_CODE = 200;//成功码.

    public static final String SUCCESS_MESSAGE = "操作成功";//成功信息.

    public static final int ERROR_CODE = 500;//错误码.

    public static final String ERROR_MESSAGE = "系统异常";//系统异常.

    public static final String ERROR = "错误";//错误信息.

    /***
     * 无参返回成功，一般适用于校验类型的接口
     *
     * @return
     */
    public static Object ok() {
        Map<String, Object> obj = new HashMap<String, Object>(2);
        obj.put("errno", 0);
        obj.put("errmsg", "接口请求成功");
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 带参返回成功，适用于任何接口
     *
     * @param data
     * @return
     */
    public static Object ok(Object data) {
        Map<String, Object> obj = new HashMap<String, Object>(4);
        obj.put("errno", 0);
        obj.put("code", 200);
        obj.put("msg", "接口请求成功");
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        obj.put("data", data);
        return obj;
    }

    /***
     * 带参与token返回成功，适用于登录接口
     *
     * @param data
     * @param token
     * @return
     */
    public static Object ok(Object data, String token) {
        Map<String, Object> obj = new HashMap<String, Object>(5);
        obj.put("errno", 0);
        obj.put("token", token);
        obj.put("code", 200);
        obj.put("msg", "接口请求成功");
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        obj.put("data", data);
        return obj;
    }

    /***
     * 带参与自定义返回接口，适用于任何接口
     *
     * @param msg
     * @param data
     * @return
     */
    public static Object ok(String msg, Object data) {
        Map<String, Object> obj = new HashMap<String, Object>(3);
        obj.put("errno", 0);
        obj.put("msg", msg);
        obj.put("data", data);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 按枚举返回错误响应结果
     *
     * @return
     */
    public static Object fail(ResponseCode responseCode) {
        return fail(responseCode.code(), responseCode.desc());
    }

    /***
     * 带参返回错误结果
     *
     * @param data
     * @return
     */
    public static Object fail(Object data) {
        Map<String, Object> obj = new HashMap<>(4);
        obj.put("code", 500);
        obj.put("errno", -1);
        obj.put("errmsg", "System Exception.");
        obj.put("err_data", data);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 带参返回错误编码
     *
     * @param codeMsg
     * @return
     */
    public static Object fail(String codeMsg) {
        Map<String, Object> obj = new HashMap<String, Object>(2);
        obj.put("errno", codeMsg);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 带参返回错误编码与通用错误信息
     *
     * @return
     */
    public static Object fail() {
        Map<String, Object> obj = new HashMap<String, Object>(2);
        obj.put("errno", -1);
        obj.put("errmsg", ERROR);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 自定义返回错误编码以及错误信息
     *
     * @param errno
     * @param errmsg
     * @return
     */
    public static Object fail(int errno, String errmsg) {
        Map<String, Object> obj = new HashMap<String, Object>(2);
        obj.put("errno", errno);
        obj.put("errmsg", errmsg);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 自定义返回错误编码，错误值以及返回信息
     *
     * @param errorCode
     * @param errorMessage
     * @param err_data
     * @return
     */
    private static Object fail(int errorCode, String errorMessage, Object err_data) {
        Map<String, Object> obj = new HashMap<String, Object>(3);
        obj.put("errno", errorCode);
        obj.put("errmsg", errorMessage);
        obj.put("err_data", err_data);
        obj.put("stamp", new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return obj;
    }

    /***
     * 默认错误返回
     *
     * @return
     */
    public static Object defaultError() {
        return fail(ERROR_CODE, ERROR_MESSAGE, null);
    }

    public static Object badArgument() {
        return fail(401, "参数异常");
    }

    public static Object badArgumentValue() {
        return fail(402, "参数值异常");
    }

    public static Object PhoneNumberDoesNotExist() {
        return fail(998, "手机号不存在");
    }

    public static Object unlogin() {
        return fail(501, "当前未登录");
    }

    public static Object serious() {
        return fail(502, "系统内部错误");
    }

    public static Object unsupport() {
        return fail(503, "业务不支持");
    }

    public static Object updatedDateExpired() {
        return fail(504, "更新数据已经失效");
    }

    public static Object updatedDataFailed() {
        return fail(505, "更新数据失败");
    }

    public static Object unauthz() {
        return fail(506, "无操作权限");
    }

}
