# opvane — AI agent operations dashboard
# JorahOne
#
# Self-contained Python HTTP server with HTML/JS frontend.
# Uses only Python stdlib — no pip dependencies required.
FROM python:3.15-alpine@sha256:0f9552bb28711333da16915ec146f5e6bb44a7fdac9ced15dc17c2e0206346dd

# Create non-root runtime user
RUN adduser -D -h /app -u 1000 appuser

WORKDIR /app

# Copy application files owned by the runtime user
COPY --chown=1000:1000 server.py .
COPY --chown=1000:1000 index.html .
COPY --chown=1000:1000 app.js .
COPY --chown=1000:1000 components.js .
COPY --chown=1000:1000 tokens.css .
COPY --chown=1000:1000 start.sh .

# Create content directory for markdown files
RUN mkdir -p content && chown -R 1000:1000 /app

EXPOSE 51763

ENV PORT=51763 BIND=0.0.0.0

USER 1000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD ["/bin/sh", "-c", "python3 -c \"import urllib.request; urllib.request.urlopen('http://localhost:${PORT:-51763}/api/health', timeout=5)\" || exit 1"]

CMD ["python3", "server.py"]
