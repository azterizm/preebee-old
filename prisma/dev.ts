import { PrismaClient } from '@prisma/client'
import { faker } from '@faker-js/faker'

const prisma = new PrismaClient()
const categories = ['makeup', 'skin_care', 'hair_care'] as const
const makeupCategories = [
  'Foundation & Primer',
  'Concealer & Color Correctors',
  'Blush & Bronzer',
  'Eyeshadow & Eyeliner',
  'Mascara & Lashes',
  'Lipstick & Lip Gloss',
  'Makeup Brushes & Tools',
  'Setting Spray & Fixatives',
  'Makeup Kits & Palettes',
  'Makeup Removers',
] as const
const skinCareCategories = [
  'Cleansers & Face Wash',
  'Moisturizers & Creams',
  'Serums & Treatments',
  'Sunscreen & SPF',
  'Face Masks & Peels',
  'Eye Creams & Treatments',
  'Toners & Essences',
  'Acne & Blemish Treatments',
  'Anti-Aging & Wrinkle Creams',
  'Lip Care & Balms',
] as const
const hairCareCategories = [
  'Shampoo & Conditioner',
  'Hair Masks & Treatments',
  'Hair Styling Products',
  'Hair Oils & Serums',
  'Hair Color & Dye',
  'Hair Brushes & Combs',
  'Hair Accessories',
  'Scalp Treatments',
  'Hair Growth & Repair',
  'Hair Tools & Appliances',
] as const

  ; (async () => {
    const seller = await prisma.seller.findFirst()
    if (!seller) return
    const user = await prisma.user.findFirst()
    if (!user) return
    for (let i = 0; i < 50; i++) {
      console.log(i)
      const category = categories[Math.floor(Math.random() * categories.length)]
      const subCategories = category === 'makeup' ? makeupCategories : category === 'skin_care' ? skinCareCategories : hairCareCategories
      const images = await Promise.all(new Array(6).fill(null).map(async () => Buffer.from(await fetch(faker.image.urlLoremFlickr({ category: 'cats', width: 200, height: 200 })).then(r => r.arrayBuffer()))))
      const reviews = new Array(faker.number.int({ min: 2, max: 6 })).fill(null).map(() => ({ userId: user.id, stars: 5, content: faker.lorem.text() }))
      const suitable = new Array(faker.number.int({ min: 2, max: 6 })).fill(null).map(() => ({ key: faker.lorem.word(), value: Math.random() > 0.5 ? 'Not suitable' : 'Suitable' }))

      await prisma.product.create({
        data: {
          title: faker.commerce.productName(),
          price: faker.number.int({ min: 50, max: 5000 }),
          sellerId: seller.id,
          status: 'Available',
          stockSpecified: 0,
          stockAcquired: faker.number.int({ min: 20, max: 100 }),
          category,
          subCategory: subCategories[Math.floor(Math.random() * subCategories.length)],
          images: { create: images.slice(1).map(r => ({ data: r })) },
          mainImage: images[0],
          reviews: { create: reviews },
          description: faker.word.words({ count: { min: 10, max: 30 } }),
          ingredients: { create: { name: faker.lorem.word() } },
          suitableFor: { create: suitable },
        }
      })
    }
  })()




