package io.apptik.rhub;


import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import io.apptik.roxy.Removable;
import io.apptik.roxy.Roxy;
import rx.Observable;


/**
 * Base implementation of {@link RxJava1Hub}
 */
public abstract class AbstractRxJava1Hub implements RxJava1Hub {

    private final Map<Object, Roxy<Observable>> proxyMap = new ConcurrentHashMap<>();

    @Override
    public final Removable addUpstream(final Object tag, final Observable observable) {
        getProxyInternal(tag).addUpstream(observable);

        return new Removable() {
            @Override
            public void remove() {
                AbstractRxJava1Hub.this.removeUpstream(tag, observable);
            }
        };
    }

    @Override
    public final void removeUpstream(Object tag, Observable observable) {
        Roxy<Observable> proxy = proxyMap.get(tag);
        if (proxy != null) {
            proxy.removeUpstream(observable);
        }
    }

    @Override
    public final Observable getPub(Object tag) {
        return getProxyInternal(tag).pub();
    }

    @Override
    @SuppressWarnings("unchecked")
    public final <T> Observable<T> getPub(Object tag, Class<T> filterClass) {
        return getProxyInternal(tag).pub(filterClass);
    }

    private Roxy<Observable> getProxyInternal(Object tag) {
        Roxy<Observable> proxy = proxyMap.get(tag);
        if (proxy == null) {
            proxy = createProxy(tag);
        }
        return proxy;
    }

    private Roxy<Observable> createProxy(Object tag) {
        Roxy<Observable> roxy = getProxyType(tag).getRoxy();
        proxyMap.put(tag, roxy);
        return roxy;
    }

    @Override
    public final void emit(Object tag, Object event) {
        if (!canTriggerEmit(tag)) {
            throw new IllegalStateException(String.format(Locale.ENGLISH,
                    "Emitting events on Tag(%s) not allowed.", tag));
        }
        getProxyInternal(tag).emit(event);
    }


    @Override
    public final void clearUpstream() {
        for (Map.Entry<Object, Roxy<Observable>> entries : proxyMap.entrySet()) {
            Roxy proxy = entries.getValue();
            proxy.clear();
        }
    }

    @Override
    public void resetProxy(Object tag) {
        Roxy proxy = proxyMap.get(tag);
        if (proxy != null) {
            proxy.clear();
            proxy.complete();
            proxyMap.remove(tag);
        }
    }

    @Override
    public void removeUpstream(Object tag) {
        Roxy proxy = proxyMap.get(tag);
        if (proxy != null) {
            proxy.clear();
            proxyMap.remove(tag);
        }
    }

}
