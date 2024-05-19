import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

let port = 3000;

async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    await app.listen(port);
}

bootstrap().then(_ => {
    console.log('server started at http://127.0.0.1:' + port);
});
