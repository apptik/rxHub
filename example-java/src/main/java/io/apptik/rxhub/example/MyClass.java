package io.apptik.rxhub.example;


import java.util.concurrent.TimeUnit;

import io.apptik.rxhub.DefaultRxJava1Hub;
import io.apptik.rxhub.RxJava1Hub;
import rx.Observable;

public class MyClass {

    public static void main(String[] args) {
        RxJava1Hub rxJava1Hub = new DefaultRxJava1Hub() {
            @Override
            public RxJava1ProxyType getProxyType(Object tag) {
                if(tag.equals("src2")) {
                    return RxJava1ProxyType.ObservableRef;
                }
                return super.getProxyType(tag);
            }
        };
       // generalExample(rxJava1Hub);
        shieldExample(rxJava1Hub);
    }

    private static void generalExample(RxJava1Hub rxJava1Hub) {
        Observable src1 = Observable.from(new Integer[] {1,3,5,7,11,13});
        Observable src2 = Observable.interval(1, TimeUnit.SECONDS);
        rxJava1Hub.addObservable("src1", src1);

        rxJava1Hub.getObservable("src1").subscribe(o -> {
            System.out.println("consumer1 (src1) got: " + o);
        });

        rxJava1Hub.getObservable("src1").subscribe(System.out::println);
        rxJava1Hub.getObservable("src1.1").subscribe(o -> {
            System.out.println("consumer1 (src1.1) got: " + o);
        });

        rxJava1Hub.addObservable("src1.1", src1.repeat(1));
        rxJava1Hub.addObservable("src2", src2.onBackpressureBuffer());

        rxJava1Hub.getObservable("src1").subscribe(o -> {
            System.out.println("consumer2 (src1) got: " + o);
        });

        rxJava1Hub.getObservable("src1.1").subscribe(o -> {
            System.out.println("consumer2 (src1.1) got: " + o);
        });
        rxJava1Hub.getObservable("src2").subscribe(o -> {
            System.out.println("consumer2 (src2) got: " + o);
        });
        new Thread(() -> {
            try {
                Thread.sleep(5000);
                rxJava1Hub.addObservable("src1.1", Observable.interval(1, TimeUnit.SECONDS));
                Thread.sleep(5000);
                rxJava1Hub.clearObservables();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }).start();
    }

    /**
     * this example demonstrates the Concept os a "Shield". Shield could be seen and a
     * abstraction layer or contract for the consumers. Its purpose is to filter, secure and/or
     * adapt the data coming from the RxJava1Hub and to relieve the consumer from this tasks.
     *
     * It can compared to an Arduino shield :)
     */
    private static void shieldExample(RxJava1Hub rxJava1Hub) {

        Shield shield = new Shield(rxJava1Hub);
        Observable srcInt = Observable.from(new Integer[] {1,3,5,7,11,13,101,201,301,401,501});
        Observable srcString = Observable.from(new String[] {"a","b","c","d","f"});

        shield.getNames().subscribe(o -> {
            System.out.println("consumer1 got: " + o);
        });

        shield.getBigOnes().subscribe(o -> {
            System.out.println("consumer2 got: " + o);
        });

        rxJava1Hub.addObservable("topic1", srcInt);
        rxJava1Hub.addObservable("topic1", srcString);

    }

    private static class Shield {
        final RxJava1Hub rxJava1Hub;
        Shield(RxJava1Hub rxJava1Hub) {
           this.rxJava1Hub = rxJava1Hub;
        }

        Observable<String> getNames() {
            return rxJava1Hub.getFilteredObservable("topic1", String.class);
        }

        Observable<Integer> getBigOnes() {
            return rxJava1Hub.getFilteredObservable("topic1", Integer.class)
                    .filter(o -> o > 100);
        }
    }
}
