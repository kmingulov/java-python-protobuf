package com.github.kmingulov.log;

import com.github.kmingulov.log.LogServiceProto.LogMessage;
import com.github.kmingulov.log.LogServiceProto.LogMessageList;
import com.github.kmingulov.log.service.LogService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class LogController {

    private final LogService logService;

    @Autowired
    public LogController(LogService logService) {
        this.logService = logService;
    }

    @PostMapping("/post")
    public ResponseEntity<LogMessage> post(@RequestBody LogMessage logMessage) {
        logService.save(logMessage);
        return new ResponseEntity<>(logMessage, HttpStatus.CREATED);
    }

    @GetMapping("/last")
    public ResponseEntity<LogMessage> last() {
        return logService.getLast()
                .map(ResponseEntity::ok)
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/last/{count}")
    public ResponseEntity<LogMessageList> last(@PathVariable("count") int count) {
        return ResponseEntity.ok(logService.getLast(count));
    }

}
