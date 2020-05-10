package com.hhit.service;

import com.hhit.entity.ErrorMsg;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:20 2020/5/8
 * @Modified By:
 */
public interface ErrorMsgService {
    void addError(ErrorMsg e);

    int getErrorListCount(ErrorMsg paramUser);

    List<ErrorMsg> getErrorList(ErrorMsg paramUser);
}
