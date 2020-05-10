package com.hhit.dao;

import com.hhit.entity.ErrorMsg;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:21 2020/5/8
 * @Modified By:
 */
public interface ErrorMsgDaoMapper {
    void addError(ErrorMsg e);

    int getErrorListCount(ErrorMsg paramUser);

    List<ErrorMsg> getErrorList(ErrorMsg paramUser);
}
