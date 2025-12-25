export type User = {
  id: string;
  name: string;
  email: string;
  password: string;
  createdAt: Date | string;
  updatedAt: Date | string;
};

export type NewUser = {
  name: string;
  email: string;
  password: string;
};
