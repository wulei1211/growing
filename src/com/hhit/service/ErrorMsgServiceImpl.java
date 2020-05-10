package com.hhit.service;

import com.hhit.dao.ErrorMsgDaoMapper;
import com.hhit.entity.ErrorMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:20 2020/5/8
 * @Modified By:
 */
@Service("errorMsgService")
public class ErrorMsgServiceImpl implements ErrorMsgService {
    @Autowired
    private ErrorMsgDaoMapper errorMsgDaoMapper;

    @Override
    public void addError(ErrorMsg e) {
        errorMsgDaoMapper.addError(e);
    }

    @Override
    public int getErrorListCount(ErrorMsg paramUser) {
        return errorMsgDaoMapper.getErrorListCount(paramUser);
    }

    @Override
    public List<ErrorMsg> getErrorList(ErrorMsg paramUser) {
        return errorMsgDaoMapper.getErrorList(paramUser);
    }
}
