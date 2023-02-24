package cn.brath.service;

import cn.brath.entity.IvDishes;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 菜品表 服务类
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
public interface IvDishesService extends IService<IvDishes> {

    /**
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    IPage<IvDishes> getDishes(Integer page, Integer size);

}
