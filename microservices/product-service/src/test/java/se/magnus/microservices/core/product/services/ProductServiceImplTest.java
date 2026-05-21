package se.magnus.microservices.core.product.services;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.OptimisticLockingFailureException;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import se.magnus.api.core.product.Product;
import se.magnus.api.exceptions.InvalidInputException;
import se.magnus.api.exceptions.NotFoundException;
import se.magnus.microservices.core.product.persistence.ProductEntity;
import se.magnus.microservices.core.product.persistence.ProductRepository;
import se.magnus.util.http.ServiceUtil;

//@ExtendWith(MockitoExtension.class)
class ProductServiceImplTest {

    @Mock
    private ProductRepository repository;

    @Mock
    private ProductMapper mapper;

    @Mock
    private ServiceUtil serviceUtil;

    @InjectMocks
    private ProductServiceImpl service;

    private ProductEntity entity;
    private Product product;

    @BeforeEach
    void setUp() {
        entity = new ProductEntity(1, "Test Product", 100);
        product = new Product(1, "Test Product", 100, "serviceAddress");
    }

    //@Test
    void createProduct_shouldReturnProduct_whenValidInput() {
        when(mapper.apiToEntity(any(Product.class))).thenReturn(entity);
        when(repository.save(any(ProductEntity.class))).thenReturn(Mono.just(entity));
        when(mapper.entityToApi(any(ProductEntity.class))).thenReturn(product);

        Mono<Product> result = service.createProduct(product);

        StepVerifier.create(result)
                .expectNext(product)
                .verifyComplete();
    }

    //@Test
    void createProduct_shouldThrowInvalidInputException_whenInvalidProductId() {
        Product invalidProduct = new Product(0, "Test", 100, null);

        assertThrows(InvalidInputException.class, () -> service.createProduct(invalidProduct));
    }

    //@Test
    void createProduct_shouldThrowInvalidInputException_whenDuplicateKey() {
        when(mapper.apiToEntity(any(Product.class))).thenReturn(entity);
        when(repository.save(any(ProductEntity.class)))
                .thenReturn(Mono.error(new DuplicateKeyException("Duplicate key")));

        Mono<Product> result = service.createProduct(product);

        StepVerifier.create(result)
                .expectErrorMatches(throwable -> throwable instanceof InvalidInputException &&
                        throwable.getMessage().contains("Duplicate key, Product Id: 1"))
                .verify();
    }

    //@Test
    void createProduct_shouldPropagateOptimisticLockingFailureException() {
        when(mapper.apiToEntity(any(Product.class))).thenReturn(entity);
        when(repository.save(any(ProductEntity.class)))
                .thenReturn(Mono.error(new OptimisticLockingFailureException("Optimistic lock failed")));

        Mono<Product> result = service.createProduct(product);

        StepVerifier.create(result)
                .expectError(OptimisticLockingFailureException.class)
                .verify();
    }

    //@Test
    void getProduct_shouldReturnProduct_whenFound() {
        when(repository.findByProductId(anyInt())).thenReturn(Mono.just(entity));
        when(mapper.entityToApi(any(ProductEntity.class))).thenReturn(product);
        when(serviceUtil.getServiceAddress()).thenReturn("serviceAddress");

        Mono<Product> result = service.getProduct(1);

        StepVerifier.create(result)
                .expectNext(product)
                .verifyComplete();
    }

    //@Test
    void getProduct_shouldThrowInvalidInputException_whenInvalidProductId() {
        assertThrows(InvalidInputException.class, () -> service.getProduct(0));
    }

    //@Test
    void getProduct_shouldThrowNotFoundException_whenNotFound() {
        when(repository.findByProductId(anyInt())).thenReturn(Mono.empty());

        Mono<Product> result = service.getProduct(1);

        StepVerifier.create(result)
                .expectError(NotFoundException.class)
                .verify();
    }

    //@Test
    void deleteProduct_shouldComplete_whenProductExists() {
        when(repository.findByProductId(anyInt())).thenReturn(Mono.just(entity));
        when(repository.delete(any(ProductEntity.class))).thenReturn(Mono.empty());

        Mono<Void> result = service.deleteProduct(1);

        StepVerifier.create(result)
                .verifyComplete();
    }

    //@Test
    void deleteProduct_shouldThrowInvalidInputException_whenInvalidProductId() {
        assertThrows(InvalidInputException.class, () -> service.deleteProduct(0));
    }

    //@Test
    void deleteProduct_shouldComplete_whenNotFound() {
        when(repository.findByProductId(anyInt())).thenReturn(Mono.empty());

        Mono<Void> result = service.deleteProduct(1);

        StepVerifier.create(result)
                .verifyComplete();
    }

    //@Test
    void deleteProduct_shouldPropagateOptimisticLockingFailureException() {
        when(repository.findByProductId(anyInt())).thenReturn(Mono.just(entity));
        when(repository.delete(any(ProductEntity.class)))
                .thenReturn(Mono.error(new OptimisticLockingFailureException("Optimistic lock failed")));

        Mono<Void> result = service.deleteProduct(1);

        StepVerifier.create(result)
                .expectError(OptimisticLockingFailureException.class)
                .verify();
    }
}