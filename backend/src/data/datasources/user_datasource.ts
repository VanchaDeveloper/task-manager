import { db } from "../../db";
import { users } from "../../db/schema";
import { NewUser, User } from "../../domain/entities/user";
import { eq } from "drizzle-orm";

export class UserDatasource {
  async insertUser(newUser: NewUser): Promise<User> {
    const [user] = await db.insert(users).values(newUser).returning();
    return user as unknown as User;
  }

  async findByEmail(email: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.email, email));
    return user as unknown as User | undefined;
  }

  async findById(id: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.id, id));
    return user as unknown as User | undefined;
  }
}
