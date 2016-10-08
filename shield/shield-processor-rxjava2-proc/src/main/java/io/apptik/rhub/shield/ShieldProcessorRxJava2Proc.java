package io.apptik.rhub.shield;

import com.google.auto.service.AutoService;

import org.reactivestreams.Publisher;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.processing.Processor;

import io.apptik.rhub.AbstractRxJava2PubHub;
import io.reactivex.Flowable;


@AutoService(Processor.class)
public class ShieldProcessorRxJava2Proc extends ShieldProcessor<AbstractRxJava2PubHub, Publisher> {

    @Override
    Class<AbstractRxJava2PubHub> hubClass() {
        return AbstractRxJava2PubHub.class;
    }

    @Override
    Set<Class<? extends Publisher>> pubClass() {
        Set<Class<? extends Publisher>> res = new HashSet<>();
        res.add(Publisher.class);
        res.add(Flowable.class);
        return res;
    }
}
