# Minnesota High School Fencing League (MNHSFL) – Website Repository

Minnesota High School Fencing League (MNHSFL) website repo.

## Testing Locally

To preview the GitHub Pages site locally using Docker:

1. Build the Docker image:
   ```sh
   docker-compose build
   ```
2. Start the Jekyll server:
   ```sh
   docker-compose up
   ```
3. Visit [http://localhost:4000](http://localhost:4000) in your browser.

This uses Jekyll with the Minima v2.5.0 theme. Internal files like `README.md` and `notes.md` are excluded from the site build.

For style changes, edit `assets/css/main.scss`.
