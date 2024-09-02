"use client";
import * as S from "./styles";

import { MessageBussines } from "./components/MessageBussines";
import { MessageClient } from "./components/MessageClient";

interface DataMessageProps {
  type: "client" | "bussines";
  message: string;
}

const data: DataMessageProps[] = [
  { type: "bussines", message: "Oiee, José aqui" },
  { type: "bussines", message: "Tudo bem?" },
  { type: "bussines", message: "Como podemos ajudar hoje?" },

  // { type: "client", message: "Fazer pedido novo" },
  // { type: "client", message: "Ver pedido pendente" },
];

export const Chat = () => {
  return (
    <S.container>
      {data.map(({ type, message }, index) => {
        if (type === "bussines") {
          return (
            <MessageBussines
              message={message}
              delay={index}
              key={crypto.randomUUID()}
            />
          );
        }

        return <MessageClient key={crypto.randomUUID()} message={message} />;
      })}
    </S.container>
  );
};
