package com.github.kmingulov.log.service;

import com.github.kmingulov.log.LogServiceProto.LogMessage;
import com.github.kmingulov.log.LogServiceProto.LogMessageList;

import java.util.List;
import java.util.Optional;

public interface LogService {

    void save(LogMessage message);

    LogMessageList getLast(int n);

    Optional<LogMessage> getLast();

}
