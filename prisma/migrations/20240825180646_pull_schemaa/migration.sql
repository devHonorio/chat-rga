-- CreateEnum
CREATE TYPE "Cobertura" AS ENUM ('CHANTILLY', 'NATA', 'CLARA_QUEIMADA', 'AVELA_BATIDO', 'KIT_KAT');

-- CreateEnum
CREATE TYPE "Formato" AS ENUM ('REDONDO', 'QUADRADO');

-- CreateEnum
CREATE TYPE "Massa" AS ENUM ('BRANCA', 'CHOCOLATE', 'MASSA_MESCLADA');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('DINHEIRO', 'PIX', 'CARTAO_DE_CREDITO', 'CARTAO_DE_DEBITO', 'DUPLICATA');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "Size" AS ENUM ('PP', 'P', 'M', 'G', 'GG', 'UNIT', 'NOT');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('RASCUNHO', 'ANOTADO', 'EM_PRODUCAO', 'ENTREGUE', 'CANCELADO');

-- CreateEnum
CREATE TYPE "TypeFrete" AS ENUM ('FRETE_MOTO', 'FRETE_CARRO');

-- CreateTable
CREATE TABLE "addresses" (
    "id" TEXT NOT NULL,
    "rua" TEXT NOT NULL,
    "numero" INTEGER NOT NULL,
    "bairro" TEXT NOT NULL,
    "ponto_de_referencia" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "frete_moto" DOUBLE PRECISION DEFAULT 5,
    "frete_carro" DOUBLE PRECISION DEFAULT 10,
    "address_complete" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "addresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bolos" (
    "id" TEXT NOT NULL,
    "peso" DOUBLE PRECISION,
    "price" DOUBLE PRECISION,
    "banner" TEXT NOT NULL DEFAULT '',
    "topper_id" TEXT,
    "order_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "description" TEXT,
    "formato" "Formato" NOT NULL DEFAULT 'REDONDO',
    "cobertura" "Cobertura" NOT NULL DEFAULT 'CHANTILLY',
    "massa" "Massa" NOT NULL DEFAULT 'BRANCA',

    CONSTRAINT "bolos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id" TEXT NOT NULL,
    "priority" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clients" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "tel" TEXT NOT NULL,
    "address_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_products" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "total" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "order_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "delivery" BOOLEAN NOT NULL DEFAULT false,
    "total" DOUBLE PRECISION NOT NULL,
    "client_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "address_id" TEXT,
    "cor_forminhas" TEXT,
    "observations" TEXT,
    "status" "Status" NOT NULL DEFAULT 'RASCUNHO',
    "type_frete" "TypeFrete" DEFAULT 'FRETE_MOTO',
    "value_frete" DOUBLE PRECISION,
    "date" TIMESTAMP(3) NOT NULL,
    "hour" TEXT NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "type" "PaymentType" NOT NULL DEFAULT 'DINHEIRO',
    "value" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "date" TIMESTAMP(3),
    "paid" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "min_quantity" INTEGER NOT NULL,
    "banner" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "category_name" TEXT NOT NULL,
    "size" "Size" NOT NULL DEFAULT 'UNIT',

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recheios" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "is_pesado" BOOLEAN NOT NULL DEFAULT false,
    "to_bento_cake" BOOLEAN NOT NULL DEFAULT true,
    "banner" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "price_fixed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "recheios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "toppers" (
    "id" TEXT NOT NULL,
    "tema" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL DEFAULT 15,
    "banner" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "description" TEXT,
    "idade" INTEGER,
    "name" TEXT,
    "recebido" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "toppers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "tel" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_BoloToRecheio" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "bolos_topper_id_key" ON "bolos"("topper_id");

-- CreateIndex
CREATE UNIQUE INDEX "categories_name_key" ON "categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "clients_tel_key" ON "clients"("tel");

-- CreateIndex
CREATE UNIQUE INDEX "users_tel_key" ON "users"("tel");

-- CreateIndex
CREATE UNIQUE INDEX "_BoloToRecheio_AB_unique" ON "_BoloToRecheio"("A", "B");

-- CreateIndex
CREATE INDEX "_BoloToRecheio_B_index" ON "_BoloToRecheio"("B");

-- AddForeignKey
ALTER TABLE "bolos" ADD CONSTRAINT "bolos_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bolos" ADD CONSTRAINT "bolos_topper_id_fkey" FOREIGN KEY ("topper_id") REFERENCES "toppers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clients" ADD CONSTRAINT "clients_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_products" ADD CONSTRAINT "order_products_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_products" ADD CONSTRAINT "order_products_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_name_fkey" FOREIGN KEY ("category_name") REFERENCES "categories"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BoloToRecheio" ADD CONSTRAINT "_BoloToRecheio_A_fkey" FOREIGN KEY ("A") REFERENCES "bolos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BoloToRecheio" ADD CONSTRAINT "_BoloToRecheio_B_fkey" FOREIGN KEY ("B") REFERENCES "recheios"("id") ON DELETE CASCADE ON UPDATE CASCADE;
