import { PrismaClient } from "@prisma/client";

const clientDB = new PrismaClient();

async function seedDB() {
  await clientDB.products.deleteMany();
  await clientDB.categories.deleteMany();

  await clientDB.categories.createMany({
    data: [
      { id: "1", name: "bolos de forma", priority: 1 },
      { id: "2", name: "doces enrolados", priority: 2 },
      { id: "3", name: "salgados", priority: 3 },
    ],
  });

  await clientDB.products.createMany({
    data: [
      {
        id: "1",
        category_name: "bolos de forma",
        min_quantity: 1,
        name: "nega maluca",
        price: 45,
      },
      {
        id: "2",
        category_name: "bolos de forma",
        min_quantity: 1,
        name: "toalha felpuda",
        price: 45,
      },
      {
        id: "3",
        category_name: "doces enrolados",
        min_quantity: 1,
        name: "brigadeiro",
        price: 0.75,
      },
      {
        id: "4",
        category_name: "doces enrolados",
        min_quantity: 1,
        name: "ninho com nutella",
        price: 0.85,
      },
      {
        id: "5",
        category_name: "salgados",
        min_quantity: 1,
        name: "coxinha",
        price: 0.7,
      },
      {
        id: "6",
        category_name: "salgados",
        min_quantity: 1,
        name: "croquete",
        price: 0.7,
      },
    ],
  });
}

beforeAll(seedDB);

test("GET /ap1/v1/status return 200", async () => {
  console.log(process.env.DATABASE_URL);
  const response = await fetch("http://localhost:3000/api/v1/status");

  expect(response.status).toBe(200);
});
