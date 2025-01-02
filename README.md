Template for integration tests using `cargo nextest` and `cargo-llvm-cov`.
The tests are built and ran separately.

```sh
docker compose up --build
docker compose cp test:/app/result ./result
```
