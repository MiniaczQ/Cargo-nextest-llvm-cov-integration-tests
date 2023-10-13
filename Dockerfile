FROM rust:1.73-bookworm as build
WORKDIR /app/
# Dependencies
RUN rustup component add llvm-tools-preview
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
RUN cargo binstall cargo-nextest --secure -y
RUN cargo binstall cargo-llvm-cov --secure -y
# Copy project files
COPY . .
RUN --mount=type=cache,target=/usr/local/cargo/registry/ \
    --mount=type=cache,target=/usr/local/cargo/git/db/ \
    --mount=type=cache,target=/app/target \
    cargo llvm-cov show-env --export-prefix >> ./envvars.sh
RUN chmod +x ./envvars.sh
RUN --mount=type=cache,target=/usr/local/cargo/registry/ \
    --mount=type=cache,target=/usr/local/cargo/git/db/ \
    --mount=type=cache,target=/app/target \
    . ./envvars.sh && cargo nextest run --no-run

FROM build as test
WORKDIR /app/
RUN --mount=type=cache,target=/usr/local/cargo/registry/ \
    --mount=type=cache,target=/usr/local/cargo/git/db/ \
    --mount=type=cache,target=/app/target \
    . ./envvars.sh && cargo nextest archive --archive-file test.tar.zst --lib --bins
ENTRYPOINT ./run-report.sh
