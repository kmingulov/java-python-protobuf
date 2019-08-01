package com.github.kmingulov.log.service;

import com.github.kmingulov.log.LogServiceProto.LogMessage;
import com.github.kmingulov.log.LogServiceProto.LogMessageList;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class InMemoryLogService implements LogService {

    private final List<LogMessage> messages = new ArrayList<>();

    @Override
    public void save(LogMessage message) {
        messages.add(message);
    }

    @Override
    public LogMessageList getLast(int n) {
        if (n <= 0) {
            throw new IllegalArgumentException("Expected a positive number.");
        }

        int start = Math.max(messages.size() - n, 0);
        List<LogMessage> listView = messages.subList(start, messages.size());

        return LogMessageList.newBuilder()
                .addAllMessage(listView)
                .build();
    }

    @Override
    public Optional<LogMessage> getLast() {
        return messages.isEmpty()
                ? Optional.empty()
                : Optional.of(messages.get(messages.size() - 1));
    }

}
