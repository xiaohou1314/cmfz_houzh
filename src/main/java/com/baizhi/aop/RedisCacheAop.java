package com.baizhi.aop;

import com.alibaba.fastjson.JSONObject;
import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.Jedis;

import java.lang.reflect.Method;
import java.util.Set;

//@Configuration
//@Aspect
public class RedisCacheAop {

    @Autowired
    private Jedis jedis;

    @Around("execution(* com.baizhi.service.*Impl.selectAll(..))")
    public Object arount(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        //判断目标方法上是否存在ReidsCache
        //如果存在,则需要做缓存
        //如果不存在，则没有缓存，直接方法放行
        //获取目标方法
        Object target = proceedingJoinPoint.getTarget();
        MethodSignature methodSignature = (MethodSignature) proceedingJoinPoint.getSignature();
        Object[] args = proceedingJoinPoint.getArgs();
        Method method = methodSignature.getMethod();
        boolean b = method.isAnnotationPresent(RedisCache.class);
        if (b){
            //目标方法上存在RedisCache注解
            //直接方法redis数据库,根据key获取对应的值
            String className = target.getClass().getName();
            String methodName = method.getName();
            StringBuilder sb = new StringBuilder();
            sb.append(className).append(".").append(methodName).append("(");
            for (int i=0;i<args.length;i++){
                sb.append(args[i]);
                if (i == args.length-1){
                    break;
                }
                sb.append(",");
            }
            sb.append(")");
            String key = sb.toString();
            System.out.println("key:"+key);
            //判断redis缓存中是否存在这个key
            if (jedis.exists(key)){
                String result = jedis.get(key);
                return JSONObject.parse(result);
            }else {
                Object result = proceedingJoinPoint.proceed();
                jedis.set(key,JSONObject.toJSONString(result));
                return result;
            }
        }else {
            Object result = proceedingJoinPoint.proceed();
            return result;
        }
    }

    @After("execution(* com.baizhi.service.*Impl.*(..)) && !execution(* com.baizhi.service.*Impl.selectAll(..))")
    public void after(JoinPoint joinPoint){
        Object target = joinPoint.getTarget();
        String className = target.getClass().getName();
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Object[] args = joinPoint.getArgs();
        Method method = methodSignature.getMethod();
        boolean b = method.isAnnotationPresent(ClearRedisCache.class);
        if (b){
            //清除缓存
            Set<String> keys = jedis.keys("*");
            for (String key : keys){
                if (key.startsWith(className)){
                    jedis.del(key);
                }
            }
        }
    }
}
