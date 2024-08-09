import { PrismaClient } from '@prisma/client'

export const prisma = new PrismaClient()

export * from '@prisma/client'

export interface Context {
  prisma: PrismaClient
}
