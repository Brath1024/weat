package cn.brath.controller;


import cn.brath.entity.IvDishes;
import cn.brath.service.IvDishesService;
import cn.brath.utils.ResponseCode;
import cn.brath.utils.ResponseUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 菜品表 前端控制器
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@RestController
@RequestMapping("/dishes")
public class IvDishesController {

    /***
     * SLF4J日志
     */
    private Logger logger = LoggerFactory.getLogger(IvDishesController.class);

    /**
     * 菜品服务接口
     */
    @Autowired
    private IvDishesService dishesService;

    /***
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/getDishes")
    public Object getDishes(@RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "size", defaultValue = "8") Integer size) {
        logger.info("【用户服务】获取菜品列表,开始");
        Map<Object, Object> result = new HashMap<>();
        IPage<IvDishes> prizeRecords = dishesService.getDishes(page, size);
        if (CollectionUtils.isEmpty(prizeRecords.getRecords())) {
            result.put("fail", ResponseCode.DATA_DOES_NOT_EXIST);
            logger.error("【用户服务】获取菜品列表,服务错误:{}", ResponseCode.DATA_DOES_NOT_EXIST);
        }
        result.put("prizeRecords", prizeRecords.getRecords());
        logger.info("【用户服务】获取菜品列表,完毕");
        return ResponseUtil.ok(result);
    }
}
