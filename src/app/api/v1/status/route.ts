import { Prisma, PrismaClient } from "@prisma/client";

export async function GET() {
  const clientDB = new PrismaClient();

  try {
    await clientDB.$connect();

    const metrics = await clientDB.$metrics.json();

    const versionResult = await clientDB.$queryRaw`SHOW server_version;`;

    const versionValue = versionResult[0]?.server_version;

    const maxConnectionsResult =
      await clientDB.$queryRaw`SHOW max_connections;`;

    const maxConnectionsValue = maxConnectionsResult[0]?.max_connections;

    const openedConnections = metrics.gauges[3].value;

    return Response.json({
      update_at: new Date().toISOString(),
      dependencies: {
        database: {
          version: +versionValue,
          max_connections: +maxConnectionsValue,
          opened_connections: openedConnections,
        },
      },
    });
  } catch (error) {
    console.log({ error });
    return Response.error();
  } finally {
    await clientDB.$disconnect();
  }
}
