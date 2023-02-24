package cn.brath.mapper;

import cn.brath.entity.IvDishes;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 菜品表 Mapper 接口
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@Mapper
public interface IvDishesMapper extends BaseMapper<IvDishes> {

    /**
     * 获取菜品列表
     *
     * @param objectPage
     * @param objectQueryWrapper
     * @return
     */
    IPage<IvDishes> getDishes(Page<Object> objectPage, QueryWrapper<Object> objectQueryWrapper);

}
