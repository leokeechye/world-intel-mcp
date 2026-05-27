# World Intelligence MCP — shared image for the dashboard and collector services.
# Dashboard service runs the default CMD (intel-dashboard, binds 0.0.0.0:$PORT).
# Collector service overrides the start command to: intel-collector --daemon --interval 300
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Build metadata + package source (hatchling reads pyproject.toml + README.md).
COPY pyproject.toml README.md ./
COPY src ./src

# [dashboard] = starlette/uvicorn, [vector] = qdrant-client/fastembed.
# PDF (weasyprint) is intentionally omitted — the /api/report/pdf route is a stub.
RUN pip install --upgrade pip && pip install ".[dashboard,vector]"

# Cosmetic; Railway routes to whatever $PORT the app binds.
EXPOSE 8501

CMD ["intel-dashboard"]
