import * as S from "./styles";

interface MessageClientProps {
  message: string;
}

export const MessageClient = ({ message }: MessageClientProps) => {
  return <S.container>{message}</S.container>;
};
