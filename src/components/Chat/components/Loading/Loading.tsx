import * as S from "./styles";

export const Loading = () => {
  return (
    <S.container>
      <S.point />
      <S.point className="delay-bounce-1" />
      <S.point className="delay-bounce-2" />
    </S.container>
  );
};
