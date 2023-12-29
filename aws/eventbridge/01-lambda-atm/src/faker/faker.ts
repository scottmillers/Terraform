import { faker } from '@faker-js/faker';



const randomName = faker.person.fullName(); // Rowan Nikolaus
const randomEmail = faker.internet.email(); // Kassandra.Haley@erich.biz

console.log(randomName);

/*
interface UserD {
    name: string;
    email: string;
}

function generateRandomUser(): UserD {
    const randomName = faker.name.findName();
    const randomEmail = faker.internet.email();

    return {
        name: randomName,
        email: randomEmail,
    };
}

const randomUser = generateRandomUser();
console.log(randomUser);
*/