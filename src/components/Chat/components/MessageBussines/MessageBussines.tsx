"use cliente";

import { useState } from "react";
import { Loading } from "../Loading";
import * as S from "./styles";

interface MessageBussinesProps {
  message: string;
  delay?: number;
}

export const MessageBussines = ({
  message,
  delay = 0,
}: MessageBussinesProps) => {
  const [isLoading, setIsLoading] = useState(true);
  const [isVisible, setIsVisible] = useState(false);

  const secondsDelay = +`${delay}000`;

  setTimeout(() => {
    setIsLoading(false);
  }, 500 + secondsDelay);

  setTimeout(() => {
    setIsVisible(true);
  }, secondsDelay);

  return (
    isVisible && (
      <>
        {isLoading && (
          <S.container>
            <Loading />
          </S.container>
        )}
        {!isLoading && (
          <S.container className="animate-scale">
            <p>{message}</p>
          </S.container>
        )}
      </>
    )
  );
};
