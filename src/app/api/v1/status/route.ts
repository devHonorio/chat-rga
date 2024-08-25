export async function GET() {
  console.log({
    base_url: process.env.DATABASE_URL,
  });

  return Response.json({});
}
