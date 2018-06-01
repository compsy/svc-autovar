#!/bin/bash
curl -X POST localhost:8080/run -d '{"value": {"a": 1}}'
curl -X POST localhost:8080/run -d @test.json
