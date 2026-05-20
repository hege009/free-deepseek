FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o ds2api ./cmd/ds2api

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/ds2api .
COPY config.example.json config.json

# Render 会自动传入 PORT 变量
ENV PORT=5001
EXPOSE 5001

# 启动时监听动态端口
CMD ["./ds2api", "--port", "$PORT"]