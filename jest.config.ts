import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand";
import nextJest from "next/jest";

dotenvExpand.expand(dotenv.config({ path: ".env.development" }));

const createJestConfig = nextJest({
  dir: ".",
});

export default createJestConfig();
