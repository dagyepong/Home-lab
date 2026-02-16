FROM node:14-alpine AS builder

RUN apk add --no-cache git

RUN adduser -D appuser
USER appuser
WORKDIR /app

RUN git clone https://github.com/photown/private-pdf.git .
RUN npm install
RUN npm run build

FROM alpine:latest

RUN mkdir /app
COPY --from=builder /app/build /app

EXPOSE 8000
USER appuser

CMD ["python", "-m", "http.server", "8000"]
