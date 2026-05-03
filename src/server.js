const app = require("./app");

const PORT = process.env.PORT || 3000;
const ENV = process.env.NODE_ENV || "development";

app.listen(PORT, () => {
  console.log("----------");
  console.log(`  Server is running`);
  console.log(`  Local:   http://localhost:${PORT}`);
  console.log(`  Mode:    ${ENV}`);
  console.log(`  Health:  http://localhost:${PORT}/health`);
  console.log("----------");
});