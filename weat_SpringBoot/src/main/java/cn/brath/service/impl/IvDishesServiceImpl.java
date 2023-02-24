package cn.brath.service.impl;

import cn.brath.entity.IvDishes;
import cn.brath.mapper.IvDishesMapper;
import cn.brath.service.IvDishesService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 菜品表 服务实现类
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@Service
public class IvDishesServiceImpl extends ServiceImpl<IvDishesMapper, IvDishes> implements IvDishesService {

    /**
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    @Override
    public IPage<IvDishes> getDishes(Integer page, Integer size) {
        return baseMapper.getDishes(new Page<>(page, size), new QueryWrapper<>());
    }
}
